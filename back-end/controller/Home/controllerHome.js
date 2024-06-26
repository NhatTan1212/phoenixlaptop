const Products = require("../../models/product");
const CART = require("../../models/cart");
const USERS = require("../../models/user");
const ORDERS = require("../../models/order");
const ORDER_DETAILS = require("../../models/orderDetails");
const REVIEWS = require("../../models/reviews");
const CATEGORIES = require("../../models/categories");
const { v4: uuidv4 } = require("uuid");
const uuid = uuidv4();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const mailer = require("../../utils/mailer.js");
const io = require("../../index.js");

const moment = require("moment");
require("dotenv").config();

//multer
var multer = require("multer");
const session = require("express-session");
const IMAGES = require("../../models/images");
const DELIVERY_ADDRESS = require("../../models/diliveryAddress");
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "public/upload");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  },
});
var upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    console.log(file);
    if (
      file.mimetype == "image/bmp" ||
      file.mimetype == "image/png" ||
      file.mimetype == "image/jpeg" ||
      file.mimetype == "image/jpg" ||
      file.mimetype == "image/gif"
    ) {
      cb(null, true);
    } else {
      return cb(new Error("Only image are allowed!"));
    }
  },
}).single("avatar");

const uploadMuti = multer({
  storage,
  fileFilter: (req, file, cb) => {
    if (
      (file.fieldname === "images" &&
        (file.mimetype === "image/png" ||
          file.mimetype === "image/jpg" ||
          file.mimetype === "image/jpeg")) ||
      (file.fieldname === "avatar" &&
        (file.mimetype === "image/png" ||
          file.mimetype === "image/jpg" ||
          file.mimetype === "image/jpeg"))
    ) {
      cb(null, true);
    } else {
      cb(null, false);
      const err = new Error(
        "Only .png, .jpg and .jpeg format allowed for images and avatar fields!"
      );
      err.name = "ExtensionError";
      return cb(err);
    }
  },
  limits: {
    fileSize: 1024 * 1024 * 5, // 5MB limit for each file
  },
  fieldNameSize: 100, // Maximum field name size
  fieldSize: 1024 * 1024 * 5, // Maximum field value size (5MB)
}).fields([
  { name: "images", maxCount: 8 },
  { name: "avatar", maxCount: 1 },
]);

function home(req, res) {
  Products.find((err, product) => {
    if (!err) {
      // console.log(product)
      // res.render("home", { data: product })
      res.json(product);
    }
  });
}

function deliveryAddress(req, res) {
  console.log('line 93 delivery address', req.body);
  let token = req.body.token;
  console.log("token =", token);
  let verify = jwt.verify(token, "secretId");
  const user_id = verify.id;
  console.log('delivery 98', user_id);
  DELIVERY_ADDRESS.findByUserId(user_id, (err, data) => {
    if (err) {
      console.log(err);
      return res.json({ success: false, err: err });
    } else {
      // console.log(data);
      return res.json({ success: true, delivery_address: data });
    }
  });
}

async function addDeliveryAddress(req, res) {
  let token = req.body.token;
  let verify = jwt.verify(token, "secretId");
  const user_id = verify.id;
  const newAddress = new DELIVERY_ADDRESS({
    user_id: user_id,
    province: req.body.province,
    district: req.body.district,
    ward: req.body.ward,
    detail_address: req.body.detail_address,
  });
  DELIVERY_ADDRESS.create(newAddress, (err, address_id) => {
    if (err) {
      console.log(err);
      return res.json({ success: false });
    }
    console.log('>> check address_id: ', address_id);
    DELIVERY_ADDRESS.findByUserId(user_id, (err, data) => {
      if (err) {
        console.log(err);
        return res.json({ success: false });
      }
      if (data.length == 1) {
        USERS.editDefaultAddressByUserId(user_id, address_id, (err, data) => {
          if (err) {
            console.log(err);
            return res.json({ success: false });
          }
        })
      }
    })
    res.json({ success: true });
  });


}

const deleteDeliveryAddress = (req, res) => {
  let token = req.body.token;
  let user_id = jwt.verify(token, "secretId").id;
  let address_id = req.body.address_id;
  USERS.findById(user_id).then(async (data) => {
    if (data.default_address === address_id + '') {
      USERS.editDefaultAddressByUserId(user_id, null, (err, data) => {
        if (err) return res.json({ success: false, msg: err })

      })
    }
    DELIVERY_ADDRESS.deleteById(user_id, address_id, (err, data) => {
      if (err) {
        res.json({ success: false });
        console.log("line 126: ControllerHome - Lỗi delete DeliveryAddress", err);
      }
      // console.log(req.body)
      res.json({ success: true });
    });
  })

};

function laptopGaming(req, res) {
  Products.findByCategoryId(1, (err, product) => {
    if (!err) {
      // console.log(req.session)
      // res.render("home", { data: product })
      res.json(product);
    }
  });
}
function laptopOffice(req, res) {
  Products.findByCategoryId(2, (err, product) => {
    if (!err) {
      // console.log(req.session)
      // res.render("home", { data: product })
      res.json(product);
    }
  });
}
function laptopLuxury(req, res) {
  Products.findByCategoryId(3, (err, product) => {
    if (!err) {
      // console.log(req.session)
      // res.render("home", { data: product })
      res.json(product);
    }
  });
}

function getLaptopsByQuery(req, res) {
  const { query } = req.params;
  console.log(query);
  let categories;
  let brands;
  let sort;

  const tableSortConvert = {
    "gia-thap-den-cao": "price asc",
    "gia-cao-den-thap": "price desc",
  };

  const splitQuery = (qr) => {
    const arrParams = qr.split("=")[1];
    console.log(arrParams);
    if (arrParams.includes(",")) {
      return "'" + arrParams.split(",").join("','") + "'";
    } else {
      return "'" + arrParams + "'";
    }
  };

  const saveValue = (qr) => {
    if (qr.includes("brand")) {
      brands = splitQuery(qr);
    }
    if (qr.includes("category")) {
      categories = splitQuery(qr);
    }
    if (qr.includes("sort")) {
      sort = qr.split("=")[1];
      sort = tableSortConvert[sort];
    }
  };

  if (query.includes("&")) {
    const arrQuery = query.split("&");
    console.log(arrQuery);
    arrQuery.forEach((qr) => {
      saveValue(qr);
    });

    Products.findByQuery(brands, categories, sort).then((data) => {
      res.json(data);
    });
  } else {
    if (query === "allproduct") {
      Products.find((err, data) => {
        if (err) console.log(err);
        else {
          res.json(data);
        }
      });
    } else {
      saveValue(query);
      Products.findByQuery(brands, categories, sort).then((data) => {
        res.json(data);
      });
    }
  }
}

function users(req, res) {
  USERS.find((err, user) => {
    if (!err) {
      console.log(req.session);
      res.json(user);
      // res.json(product)
    }
  });
}

function userById(req, res) {
  const userId = USERS.findById(req.params.id);
  userId.then((user) => {

    DELIVERY_ADDRESS.findByUserId(user.id, (err, data) => {
      if (err) return res.json({ success: false })
      const foundAddressObj = data.find(item => item.id === parseInt(user.default_address));
      const default_address = foundAddressObj ? `${foundAddressObj.detail_address}, ${foundAddressObj.province}, ${foundAddressObj.district}, ${foundAddressObj.ward}` : ''
      const newUser = {
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        role: user.role,
        default_address_id: user.default_address,
        default_address: default_address
      };
      res.json(newUser);
    })
  });
}

function listImage(req, res) {
  IMAGES.find((err, img) => {
    if (!err) {
      res.json(img);
      // res.json(product)
    }
  });
}

function management(req, res) {
  Products.find((err, product) => {
    if (!err) {
      console.log(req.session);
      // res.render("management", { data: product })
      res.json(product);
    }
  });
}

async function editProduct(req, res) {
  const productId = req.params.id;
  console.log(productId);
  const product = await Products.findById(productId);
  if (product.length === 0) {
    return res.json({ kq: 0, errMsg: "Product not found" });
  } else {
    console.log(product[0].id);
    res.render("editProduct", { data: product[0] });
    // res.json(product[0])
  }
  // res.render('editProduct')
}

async function editProductPost(req, res) {
  console.log("body", req.body);
  console.log("files", req.files);

  const productId = String(req.body.IDProduct);

  let numCreate = 0;
  let createFinish = false;
  let dem = 0;
  let numDeleted = 0;
  let updateProductFinish = false;
  let updateImagesFinish = false;
  let deleteFinish = false;

  const updateProductData = {
    brand_id: req.body.brand_id,
    category_id: req.body.category_id,
    prod_name: req.body.prod_name,
    prod_description: req.body.prod_description,
    detailed_evaluation: req.body.detailed_evaluation,
    manufacturer: req.body.manufacturer,
    price: req.body.price,
    cost: req.body.cost,
    quantity: req.body.quantity,
    prod_percent: req.body.prod_percent,
    cpu: req.body.cpu,
    hard_drive: req.body.hard_drive,
    ram: req.body.ram,
    mux_switch: req.body.mux_switch,
    screen: req.body.screen,
    webcam: req.body.webcam,
    connection: req.body.connection,
    prod_weight: req.body.prod_weight,
    pin: req.body.pin,
    operation_system: req.body.operation_system,
    graphics: req.body.graphics,
    on_board: req.body.on_board,
  };

  //Update Avata
  if (req.files.avatar) {
    updateProductData.avatar =
      "http://localhost:8000/upload/products/" + req.files.avatar[0].filename;
  } else {
    updateProductData.avatar = req.body.avatar;
  }

  if (req.body.images) {
    let listImages = Array.isArray(req.body.images)
      ? req.body.images
      : [req.body.images];
    let listImagesID = req.body.image_id;
    console.log(listImagesID);
    IMAGES.find((err, images) => {
      // console.log(images)
      //Delete Images thừa
      if (images.length > listImages.length) {
        images.forEach((image) => {
          if (!listImagesID.includes(String(image.image_id))) {
            console.log(image.image_id);
            IMAGES.deleteById(
              productId,
              String(image.image_id),
              (err, result) => {
                numDeleted++; // Tăng biến đếm sau mỗi lần xóa

                // Kiểm tra nếu đã xóa đủ số lượng cần xóa
                if (numDeleted === images.length - listImages.length) {
                  deleteFinish = true;
                  // Kiểm tra điều kiện để thực hiện hành động kết thúc
                  if (
                    updateImagesFinish &&
                    updateProductFinish &&
                    deleteFinish &&
                    createFinish
                  ) {
                    return res.json({ success: true });
                  }
                }
              }
            );
          }
        });
      } else {
        deleteFinish = true;
        // Kiểm tra điều kiện để thực hiện hành động kết thúc
        if (
          updateImagesFinish &&
          updateProductFinish &&
          deleteFinish &&
          createFinish
        ) {
          return res.json({ success: true });
        }
      }
    });
    listImages.forEach(async (image, index) => {
      await IMAGES.updateById(productId, index + 1, image, (err, product) => {
        if (err) {
          return res.json({ kq: 0, errMsg: err });
        }
        dem++;
        // console.log(dem, listImages.length)
        if (dem == listImages.length) {
          updateImagesFinish = true;
          if (
            updateImagesFinish &&
            updateProductFinish &&
            deleteFinish &&
            createFinish
          ) {
            return res.json({ success: true });
          }
        }
        // return res.json({ success: true });
      });
    });
  } else {
    deleteFinish = true;
    updateImagesFinish = true;
    if (
      updateImagesFinish &&
      updateProductFinish &&
      deleteFinish &&
      createFinish
    ) {
      return res.json({ success: true });
    }
  }

  //Add New Images
  if (req.files.images) {
    let listImage = req.files.images;
    listImage.forEach((image) => {
      const newImage = new IMAGES({
        product_id: productId,
        url: "http://localhost:8000/upload/products/" + image.filename,
      });
      IMAGES.create(newImage, (err, result) => {
        numCreate++;
        console.log(numCreate, req.files.images.length);
        if (numCreate === req.files.images.length) {
          createFinish = true;
          // Kiểm tra điều kiện để thực hiện hành động kết thúc
          if (
            updateImagesFinish &&
            updateProductFinish &&
            deleteFinish &&
            createFinish
          ) {
            return res.json({ success: true });
          }
        }
      });
    });
  } else {
    createFinish = true;
    if (
      updateImagesFinish &&
      updateProductFinish &&
      deleteFinish &&
      createFinish
    ) {
      return res.json({ success: true });
    }
  }

  await Products.updateById(productId, updateProductData, (err, product) => {
    if (err) {
      return res.json({ kq: 0, errMsg: err });
    }
    // return res.json({ success: true });
    updateProductFinish = true;
    if (
      updateImagesFinish &&
      updateProductFinish &&
      deleteFinish &&
      createFinish
    ) {
      return res.json({ success: true });
    }
  });

  // });
}

async function addUser(req, res) {
  try {
    const hashedPass = await bcrypt.hash(req.body.password, 10);
    const newUser = new USERS({
      name: req.body.name,
      password: hashedPass,
      email: req.body.email,
      role: req.body.role,
    });

    USERS.findByEmail(newUser.email, (err, user) => {
      if (err) {
        return res.json({
          success: false,
          message: "Đã xảy ra lỗi khi kiểm tra email",
        });
      }

      if (user) {
        return res.json({ success: false, message: "Email đã tồn tại" });
      }

      USERS.addNewUser(newUser, (err, savedUser) => {
        if (err) {
          return res.json({
            success: false,
            message: "Đã xảy ra lỗi khi thêm người dùng mới",
          });
        }
        return res.json({
          success: true,
          message: "Người dùng đã được thêm thành công",
        });
      });
    });
  } catch (error) {
    console.error(error);
    return res.json({
      success: false,
      message: "Đã xảy ra lỗi trong quá trình xử lý yêu cầu",
    });
  }
}

async function deleteUser(req, res) {
  console.log(req.body);
  USERS.deleteByUserId(req.body.user_id, (err, user) => {
    if (err) {
      res.json({ success: false });
      console.log(err);
    }
    console.log(req.body);
    res.json({ success: true });
  });
}

async function editUserManagement(req, res) {
  console.log(req.body);

  try {
    const userData = await USERS.findById(req.body.id);
    console.log(`userData: ${userData}`);
    let currentPassword = "";

    if (req.body.password === "") {
      currentPassword = userData.password;
      console.log(`currentPassword: ${currentPassword}`);
    } else {
      const hashedPass = await bcrypt.hash(req.body.password, 10);
      currentPassword = hashedPass;
    }

    const newUser = {
      id: req.body.id,
      name: req.body.name,
      password: currentPassword,
      role: req.body.role,
    };

    USERS.editByUserId(newUser, (err, user) => {
      if (err) {
        res.json({ success: false });
        console.log(err);
        return;
      }
      console.log(req.body);
      res.json({ success: true });
    });
  } catch (error) {
    console.log(error);
    res.json({ success: false, error: error.message });
  }
}

async function editUserInfo(req, res) {
  console.log('body line 597 ', req.body);

  try {
    const newUser = {
      id: req.body.id,
      name: req.body.name,
      phone: req.body.phone,
      defAddressID: req.body.defAddressID
    };

    USERS.editUserInfoByUserId(newUser, (err, user) => {
      if (err) {
        res.json({ success: false });
        console.log(err);
        return;
      }
      res.json({ success: true });
    });
  } catch (error) {
    console.log(error);
    res.json({ success: false, error: error.message });
  }
}

async function editUserInfoPassWord(req, res) {
  try {
    const userData = await USERS.findById(req.body.id);

    bcrypt.compare(
      req.body.oldPassword,
      userData.password,
      async (err, data) => {
        if (err) {
          res.json({ success: false, message: err });
        } else if (!err && data) {
          const hashedNewPassword = await bcrypt.hash(req.body.newPassword, 10);

          USERS.resetPasswordById(
            req.body.id,
            hashedNewPassword,
            (err, data) => {
              if (err) {
                res.json({
                  success: false,
                  message: "Có lỗi xảy ra, vui lòng thử lại sau.",
                });
                return;
              } else {
                res.json({
                  success: true,
                  message: "Thay đổi mật khẩu thành công.",
                });
              }
            }
          );
        } else {
          res.json({ success: false, message: "Mật khẩu cũ không đúng." });
        }
      }
    );
  } catch (error) {
    console.log(error);
    res.json({ success: false, error: error.message });
  }
}

async function deleteProduct(req, res) {
  console.log(req.body);
  IMAGES.deleteAllByProductId(req.body.product_id, (err, product) => {
    if (err) {
      res.json({ success: false });
      console.log(err);
    }
    Products.deleteById(req.body.product_id, (err, product) => {
      if (err) {
        res.json({ kq: 0, errMsg: err });
      } else {
        res.json({ success: true });
      }
    });
  });
}

const getUsersFromReviews = async (reviews) => {
  const userIds = reviews.map((review) => review.user_id);

  try {
    const users = await Promise.all(
      userIds.map((userId) => USERS.findById(userId))
    );
    return users;
  } catch (error) {
    throw error;
  }
};

async function productDetail(req, res) {
  try {
    const productId = req.params.id;

    const product = await Products.findById(productId);
    if (product.length === 0) {
      return res.json({ kq: 0, errMsg: "Product not found" });
    }
    const category = await CATEGORIES.findById(product[0].category_id);
    // console.log(category[0].name)

    const images = await IMAGES.findByProductId(productId);

    // const reviews = await REVIEWS.findByProductId(productId);
    // const users = await getUsersFromReviews(reviews);
    // console.log(users)
    // const nameUsersRated = users.map(user => user[0].name);
    // console.log(nameUsersRated)

    const responseData = {
      data: product[0],
      category: category[0].name,
      images: images,
      // reviews: reviews,
      // nameUsersRated: nameUsersRated,
      slug: category[0].slug,
    };

    res.json(responseData);
  } catch (error) {
    console.error(error);
    res.status(500).json({ kq: 0, errMsg: "Server error" });
  }
}

function cart(req, res) {
  let token = req.body.token;
  let tokenGID = req.body.tokenGID;
  console.log(token, tokenGID);
  if (token) {
    let verify = jwt.verify(token, "secretId");
    console.log("line 632 controllerHome verifyToken: ", verify);
    // res.render('cart')
    CART.findById(verify.id, (err, cart) => {
      if (!err) {
        // console.log(cart)
        // res.render("cart", { data: cart })
        USERS.findById(verify.id).then((user) => {
          console.log('cart', parseInt(user.default_address));
          DELIVERY_ADDRESS.findByAddressId(parseInt(user.default_address), (err, data) => {
            if (err) return res.json({ success: false, msg: err })
            if (data) {
              const default_address = `${data.detail_address}, ${data.province}, ${data.district}, ${data.ward}`
              if (cart[0]) cart[0]["default_address"] = default_address;
            }
            console.log(cart);
            return res.json(cart)
          })

        })

      }
    });
  } else if (tokenGID) {
    CART.findByGID(tokenGID, (err, cart) => {
      if (!err) {
        // console.log(cart)
        // res.render("cart", { data: cart })
        res.json(cart);
      }
    });
  }
}

function cartServer(req, res) {
  CART.findById(2015, (err, cart) => {
    if (!err) {
      // console.log(cart)
      res.render("cart", { data: cart });
      // res.json(cart)
    }
  });
}

let isAlreadyInCart = false;

function addCart(req, res) {
  console.log(req.body);
  let token = req.body.token;
  let tokenGID = req.body.tokenGID;
  // console.log(token, tokenGID)
  if (token !== undefined) {
    let verify = jwt.verify(token, "secretId");
    console.log(verify);
    CART.findById(verify.id, (err, cart) => {
      if (!err) {
        let foundInCart = false;

        cart.forEach((cartItem) => {
          if (
            cartItem.user_id == verify.id &&
            cartItem.product_id == req.body.product_id
          ) {
            // console.log(cartItem);
            foundInCart = true;

            CART.updateById(
              verify.id,
              req.body.product_id,
              req.body.count,
              req.body.quantity,
              (err, data) => {
                if (!err) {
                  if (data.data == 0) {
                    res.json({ success: false, message: 'Số lượng sản phẩm vượt quá giới hạn.' });
                    return
                  }
                  res.json({ success: true, redirectUrl: "../cart" });
                }
              }
            );
          }
        });

        console.log(foundInCart);
        if (foundInCart === false) {
          const newCartItem = new CART({
            user_id: verify.id,
            product_id: req.body.product_id,
            guest_id: null,
            product_name: req.body.product_name,
            avatar: req.body.avatar,
            prod_description: req.body.prod_description,
            price: req.body.price,
            quantity: req.body.quantity,
            count: req.body.count,
          });
          console.log(newCartItem);

          CART.create(newCartItem, (err, Cart) => {
            if (!err) {
              res.json({ success: true, redirectUrl: "../cart" });
            }
          });
        }

        isAlreadyInCart = false; // Đặt lại giá trị của isAlreadyInCart thành false sau khi xử lý mỗi sản phẩm
      }
    });
  } else if (tokenGID !== undefined) {
    console.log(tokenGID);
    CART.findByGID(tokenGID, (err, cart) => {
      if (!err) {
        let foundInCart = false;

        cart.forEach((cartItem) => {
          if (
            cartItem.guest_id == tokenGID &&
            cartItem.product_id == req.body.product_id
          ) {
            // console.log(cartItem);
            foundInCart = true;

            CART.updateByGID(
              tokenGID,
              req.body.product_id,
              req.body.count,
              req.body.quantity,
              (err, data) => {
                if (!err) {
                  if (data.data == 0) {
                    res.json({ success: false, message: 'Số lượng sản phẩm vượt quá giới hạn.' });
                    return
                  }
                  res.json({ success: true, redirectUrl: "../cart" });
                }
              }
            );
          }
        });

        console.log(foundInCart);
        if (foundInCart === false) {
          const newCartItem = new CART({
            user_id: null,
            product_id: req.body.product_id,
            guest_id: tokenGID,
            count: req.body.count,
          });
          console.log(newCartItem);

          CART.create(newCartItem, (err, Cart) => {
            if (!err) {
              res.json({ success: true, redirectUrl: "../cart" });
            }
          });
        }

        isAlreadyInCart = false; // Đặt lại giá trị của isAlreadyInCart thành false sau khi xử lý mỗi sản phẩm
      }
    });
  }
}

function deleteCart(req, res) {
  let token = req.body.token;
  let tokenGID = req.body.tokenGID;

  const handleDelete = (user_id, guest_id, product_id) => {
    CART.deleteCart(user_id, guest_id, product_id, (err, product) => {
      if (err) {
        res.json({ kq: 0, errMsg: err });
      } else {
        res.json({ success: true });
      }
    });
  };

  if (token !== undefined) {
    try {
      let verify = jwt.verify(token, "secretId");
      let user_id = verify.id;
      handleDelete(user_id, null, req.body.product_id);
    } catch (err) {
      res.json({ kq: 0, errMsg: err.message });
    }
  } else if (tokenGID !== undefined) {
    handleDelete(null, tokenGID, req.body.product_id);
  }
}

async function updateCart(req, res) {
  let token = req.body.token;
  let tokenGID = req.body.tokenGID;
  let cart = req.body.cart;

  const updateCartByUser = (userId, product) => {
    CART.updateByIdFromCart(
      userId,
      product.product_id,
      product.count,
      product.is_possible_to_order,
      (err, cart) => {
        if (err) {
          console.log(err);
        }
      }
    );
  };

  const updateCartByGuest = (guestId, product) => {
    CART.updateByGIDFromCart(
      guestId,
      product.product_id,
      product.count,
      product.is_possible_to_order,
      (err, cart) => {
        if (err) {
          console.log(err);
        }
      }
    );
  };

  if (token !== undefined) {
    try {
      let verify = jwt.verify(token, "secretId");
      const userId = verify.id;
      cart.forEach((item) => {
        updateCartByUser(userId, item);
      });
      if (req.body.default_address) {
        await USERS.editDefaultAddressByUserId(userId, req.body.default_address, (err, data) => {
          if (err) return res.json({ success: false, msg: err });
        })
      }

      res.json({ success: true });
    } catch (err) {
      res.json({ kq: 0, errMsg: err.message });
    }
  } else if (tokenGID !== undefined) {
    cart.forEach((item) => {
      updateCartByGuest(tokenGID, item);
    });
    res.json({ success: true });
  }
}

function checkout(req, res) {
  let token = req.cookies.token;
  let verify = jwt.verify(token, "secretId");
  let productIds = req.query.product_id;
  let dataUser;
  let dataCart = [];
  let totalMoney = 0;
  if (!Array.isArray(productIds)) {
    // Chuyển đổi thành mảng nếu không phải là mảng
    productIds = [productIds];
  }
  // console.log(productIds)
  // res.json(productIds)
  USERS.findById(verify.id, (err, user) => {
    if (!err) {
      dataUser = user;
      let completedRequests = 0;
      productIds.forEach((productId) => {
        CART.findByProductId(productId, (err, cart) => {
          if (!err) {
            if (!dataCart.includes(cart[0])) {
              dataCart.push(cart[0]);
              totalMoney += cart[0].product_total;
            }
          }
          completedRequests++;
          if (completedRequests === productIds.length) {
            console.log(dataUser, dataCart);
            res.render("checkout", {
              dataUser: dataUser[0],
              dataCart: dataCart,
              totalMoney: totalMoney,
            });
            res.json({
              dataUser: dataUser[0],
              dataCart: dataCart,
              totalMoney: totalMoney,
            });
          }
        });
      });
    } else {
      console.error(err);
      res.render("error");
    }
  });
  // res.render('checkout')
}

const mailerOrderSuccessfully = (email, data, productList, orderId) => {
  mailer.sendMail(
    email,
    "[PhoenixLaptop] Thông tin đơn đặt hàng",
    `
        <div style="background-color: #f0f9eb; border: 1px solid #b7eb8f; color: #4caf50; padding: 20px; border-radius: 5px; margin-bottom: 20px;">
        <h1 style="font-size: 24px;">Bạn đã đặt hàng thành công - Mã đơn hàng #${orderId}</h1>
        <h2 style="font-size: 20px;">Thông tin giao hàng:</h2>
        <p><strong>Tên người nhận:</strong> ${data.name}</p>
        <p><strong>Số điện thoại:</strong> ${data.phone}</p>
        <p><strong>Địa chỉ nhận hàng:</strong> ${data.userAddress}</p>
      
        <h2 style="font-size: 20px;">Danh sách sản phẩm đã đặt:</h2>
        <table style="width: 100%; border-collapse: collapse;">
          <tr>
            <th style="background-color: #4caf50; color: white; border: 1px solid #ddd; padding: 8px;">STT</th>
            <th style="background-color: #4caf50; color: white; border: 1px solid #ddd; padding: 8px;">Hình ảnh</th>
            <th style="background-color: #4caf50; color: white; border: 1px solid #ddd; padding: 8px;">Tên sản phẩm</th>
            <th style="background-color: #4caf50; color: white; border: 1px solid #ddd; padding: 8px;">Đơn giá</th>
            <th style="background-color: #4caf50; color: white; border: 1px solid #ddd; padding: 8px;">Số lượng</th>
          </tr>
          ${productList}
        </table>
      
        <h2 style="font-size: 20px;">Thanh toán:</h2>
        <p><strong>Tổng tiền:</strong> ${data.total} VNĐ</p>
        <p><strong>Hình thức thanh toán:</strong> ${data.paymentMethod}</p>
      </div>
      
        `
  );
};

async function dataOrder(req, res) {
  const token = req.body.token;
  const tokenGID = req.body.tokenGID;
  let uid = null;
  let gid = null;
  // console.log(req.body.listProduct);
  for (const product of req.body.listProduct) {
    const productInDb = await Products.findById(product.product_id);
    console.log(
      "line910 controllerHome - productInDb: ",
      productInDb[0].quantity,
      "product: ",
      product.count
    );
    if (productInDb[0].quantity - product.count < 0) {
      // console.log('lọt vào đây');
      return res.json({
        success: false,
        msg: `Số lượng ${product.prod_name} trong kho không đủ.`,
      });
    }
  }
  // return res.send('true')
  // Tạo một đối tượng order để sử dụng chung
  const newOrder = new ORDERS({
    user_id: null,
    guest_id: null,
    avatar: req.body.avatar,
    prod_name: req.body.prod_name,
    note: req.body.note,
    paymentMethods: req.body.paymentMethod,
    quantity: req.body.quantity,
    total_product: req.body.total_product,
    total: req.body.total,
    name: req.body.name,
    email: req.body.email,
    user_address: req.body.userAddress,
    phone: req.body.phone,
    trading_code: "0",
    is_payment: 0,
    is_approved: 0,
    is_being_shipped: 0,
    is_transported: 0,
    is_success: 0,
    vnp_TransactionNo: null,
    vnp_PayDate: null,
    vnp_OrderInfo: null,
    vnp_CardType: null,
    vnp_BankCode: null,
  });

  if (token !== undefined) {
    const verify = jwt.verify(token, "secretId");
    newOrder.user_id = verify.id;
    uid = verify.id;
    if (req.body.default_address) {
      await USERS.editDefaultAddressByUserId(verify.id, req.body.default_address, (err, data) => {
        if (err) return res.json({ success: false, msg: err });
      })
    }
  } else if (tokenGID !== undefined) {
    newOrder.guest_id = tokenGID;
    gid = tokenGID;
  }
  let productList = "";

  // Tạo danh sách sản phẩm gửi mail cho khách hàng
  req.body.listProduct.forEach((product, index) => {
    productList += `
        <tr style="border-bottom: 1px solid #e5e5e5">
          <td>${index + 1}</td>
          <td style="text-align: center"><img style="height: 120px" src="${product.avatar}"></td>
          <td>${product.prod_name}</td>
          <td>${product.price}</td>
          <td>${product.count}</td>
        </tr>
        `;
  });


  if (req.body.paymentMethod === "VNPAY") {
    let getPayDate = req.body.vnp_PayDate;
    console.log(getPayDate);
    const formattedPayDate =
      getPayDate.slice(0, 4) +
      "-" +
      getPayDate.slice(4, 6) +
      "-" +
      getPayDate.slice(6, 8) +
      " " +
      getPayDate.slice(8, 10) +
      ":" +
      getPayDate.slice(10, 12) +
      ":" +
      getPayDate.slice(12, 14);

    console.log(formattedPayDate);
    newOrder.vnp_TransactionNo = req.body.vnp_TransactionNo;
    newOrder.vnp_PayDate = formattedPayDate;
    newOrder.vnp_OrderInfo = req.body.vnp_OrderInfo;
    newOrder.vnp_CardType = req.body.vnp_CardType;
    newOrder.vnp_BankCode = req.body.vnp_BankCode;
    ORDERS.findByVnpTransactionNo(newOrder.vnp_TransactionNo, (err, data) => {
      if (err) {
        console.log(err);
        res.join({ success: false, err: err });
      } else {
        if (!data || data.length === 0 || data === "") {
          console.log("Đang tạo mới đơn hàng");
          ORDERS.create(newOrder, (err, order) => {
            if (err) {
              return res.json({ success: false, error: err });
            }
            console.log('line 1178 - order: ', order);

            const completedRequests = req.body.listProduct.length;
            let requestsCompleted = 0;

            req.body.listProduct.forEach((product) => {
              const orderDetails = new ORDER_DETAILS({
                product_id: product.product_id,
                order_id: order.id,
                quantity: product.count,
                price: product.price,
              });

              ORDER_DETAILS.create(orderDetails, (err) => {
                if (err) {
                  console.log(
                    "Lỗi tại controllerHome:line 1002 (ORDER_DETAILS.create) - " +
                    err
                  );
                  return json({ success: false, err: err });
                }
              });
              Products.updateDecreaseQuantityById(
                product.product_id,
                product.count,
                (err, data) => {
                  if (err) {
                    console.log(
                      "Lỗi tại controllerHome:line 1008 (updateDecreaseQuantityById) - " +
                      err
                    );
                    return json({ success: false, err: err });
                  }
                }
              );
              CART.updateDecreaseQuantityByProductId(
                product.product_id,
                product.count,
                (err, data) => {
                  if (err) {
                    console.log(
                      "Lỗi tại controllerHome:line 1014 (updateDecreaseQuantityById) - " +
                      err
                    );
                    return json({ success: false, err: err });
                  }
                }
              );
              CART.deleteCart(uid, gid, product.product_id, (err, data) => {
                if (err) {
                  console.log(
                    "Lỗi tại controllerHome:line 1020 (deleteCart) - " + err
                  );
                  return json({ success: false, err: err });
                } else {
                  requestsCompleted++;
                  let email = req.body.email;
                  console.log(
                    "line 924: controllerHome.js - requestsCompleted and completedRequests",
                    requestsCompleted,
                    completedRequests
                  );
                  if (requestsCompleted === completedRequests) {
                    mailerOrderSuccessfully(email, req.body, productList, order.id);

                    res.json({
                      success: true,
                      redirectUrl: "../order",
                      order_id: order.id,
                    });
                  }
                }
              });
            });
          });
        } else {
          console.log(data);
          console.log("Đã có đơn hàng này trong cơ sở dữ liệu");
          res.json({ success: true });
          return;
        }
      }
    });
  } else {
    ORDERS.create(newOrder, (err, order) => {
      if (err) {
        return res.json({ success: false, error: err });
      }
      console.log("line 888: controllerHome.js - idOrderLast: ", order);

      const completedRequests = req.body.listProduct.length;
      let requestsCompleted = 0;

      req.body.listProduct.forEach((product) => {
        const orderDetails = new ORDER_DETAILS({
          product_id: product.product_id,
          order_id: order,
          quantity: product.count,
          price: product.price,
        });

        ORDER_DETAILS.create(orderDetails, (err) => {
          if (err) {
            console.log(
              "Lỗi tại controllerHome:line 857 (ORDER_DETAILS.create) - " + err
            );
            return json({ success: false, err: err });
          }
        });
        Products.updateDecreaseQuantityById(
          product.product_id,
          product.count,
          (err, data) => {
            if (err) {
              console.log(
                "Lỗi tại controllerHome:line 861 (updateDecreaseQuantityById) - " +
                err
              );
              return json({ success: false, err: err });
            }
          }
        );
        CART.updateDecreaseQuantityByProductId(
          product.product_id,
          product.count,
          (err, data) => {
            if (err) {
              console.log(
                "Lỗi tại controllerHome:line 1014 (updateDecreaseQuantityById) - " +
                err
              );
              return json({ success: false, err: err });
            }
          }
        );
        CART.deleteCart(uid, gid, product.product_id, (err, data) => {
          if (err) {
            console.log(
              "Lỗi tại controllerHome:line 919 (deleteCart) - " + err
            );
            return res.json({ success: false, err: err });
          } else {
            requestsCompleted++;
            let email = req.body.email;
            console.log(
              "line 924: controllerHome.js - requestsCompleted and completedRequests",
              requestsCompleted,
              completedRequests
            );
            if (requestsCompleted === completedRequests) {
              mailerOrderSuccessfully(email, req.body, productList, order);
              global.io.emit("newOrder", req.body);
              res.json({
                success: true,
                redirectUrl: "../order",
                order_id: order,
                order: req.body
              });
            }
          }
        });
      });
    });
  }
}

function sortObject(obj) {
  let sorted = {};
  let str = [];
  let key;
  for (key in obj) {
    if (obj.hasOwnProperty(key)) {
      str.push(encodeURIComponent(key));
    }
  }
  str.sort();
  for (key = 0; key < str.length; key++) {
    sorted[str[key]] = encodeURIComponent(obj[str[key]]).replace(/%20/g, "+");
  }
  return sorted;
}

async function createPaymentVNPAY(req, res) {
  for (const product of req.body.listProduct) {
    const productInDb = await Products.findById(product.product_id);
    console.log(
      "line910 controllerHome - productInDb: ",
      productInDb[0].quantity,
      "product: ",
      product.count
    );
    if (productInDb[0].quantity - product.count < 0) {
      // console.log('lọt vào đây');
      return res.json({
        success: false,
        msg: `Số lượng ${product.prod_name} trong kho không đủ.`,
      });
    }
  }
  process.env.TZ = "Asia/Ho_Chi_Minh";

  let date = new Date();
  let createDate = moment(date).format("YYYYMMDDHHmmss");

  let ipAddr =
    req.headers["x-forwarded-for"] ||
    req.connection.remoteAddress ||
    req.socket.remoteAddress ||
    req.connection.socket.remoteAddress;

  let tmnCode = process.env.vnp_TmnCode;
  let secretKey = process.env.vnp_HashSecret;
  let vnpUrl = process.env.vnp_Url;
  let returnUrl = process.env.vnp_ReturnUrl;
  let orderId = moment(date).format("DDHHmmss");
  let amount = req.body.amount;
  let bankCode = req.body.bankCode;

  let locale = req.body.language;
  if (locale === null || locale === "") {
    locale = "vn";
  }
  let currCode = "VND";
  let vnp_Params = {};
  vnp_Params["vnp_Version"] = "2.1.0";
  vnp_Params["vnp_Command"] = "pay";
  vnp_Params["vnp_TmnCode"] = tmnCode;
  vnp_Params["vnp_Locale"] = locale;
  vnp_Params["vnp_CurrCode"] = currCode;
  vnp_Params["vnp_TxnRef"] = orderId;
  vnp_Params["vnp_OrderInfo"] = "Thanh toan cho ma GD:" + orderId;
  vnp_Params["vnp_OrderType"] = "other";
  vnp_Params["vnp_Amount"] = amount * 100;
  vnp_Params["vnp_ReturnUrl"] =
    `http://localhost:3000/Phoenix-technology#` + returnUrl;
  vnp_Params["vnp_IpAddr"] = ipAddr;
  vnp_Params["vnp_CreateDate"] = createDate;
  if (bankCode !== null && bankCode !== "") {
    vnp_Params["vnp_BankCode"] = bankCode;
  }

  vnp_Params = sortObject(vnp_Params);
  console.log(vnp_Params);

  let querystring = require("qs");
  let signData = querystring.stringify(vnp_Params, { encode: false });
  let crypto = require("crypto");
  let hmac = crypto.createHmac("sha512", secretKey);
  let signed = hmac.update(new Buffer(signData, "utf-8")).digest("hex");
  console.log("signed = ", signed);
  vnp_Params["vnp_SecureHash"] = signed;
  vnpUrl += "?" + querystring.stringify(vnp_Params, { encode: false });
  res.json({ success: true, redirect: vnpUrl });
}

function order(req, res) {
  const token = req.body.token;
  const tokenGID = req.body.tokenGID;
  let verify;
  let userId;
  if (token) {
    verify = jwt.verify(token, "secretId");
    userId = verify.id;
  }
  // console.log(typeof userId)
  ORDERS.findById(userId, tokenGID, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      // res.render("order", { data: order })
      // console.log(order)
      res.json(order);
    }
  });
}

function orderDetails(req, res) {
  let dataProduct = [];
  let completedRequests = 0;
  console.log(req.params.id);
  ORDER_DETAILS.findById(req.params.id, (err, orderDetails) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      orderDetails.forEach(async (orderDetail) => {
        const product = await Products.findById(orderDetail.product_id);
        if (product.length === 0) {
          return res.json({ kq: 0, errMsg: "Product not found" });
        }

        dataProduct.push(product[0]);

        // console.log(product[0].id)
        // res.render("productDetail", { data: product[0] })
        // res.json(product[0])

        completedRequests++;
        if (completedRequests === orderDetails.length) {
          console.log("xong");
          res.json({ orderDetails: orderDetails, dataProduct: dataProduct });
        }
      });
      // res.render("editorderDetails", { data: orderDetails[0] })
    }
  });
}

function orderDetails(req, res) {
  let dataProduct = [];
  let completedRequests = 0;
  console.log(req.params.id);
  ORDER_DETAILS.findById(req.params.id, (err, orderDetails) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      orderDetails.forEach(async (orderDetail) => {
        const product = await Products.findById(orderDetail.product_id);
        if (product.length === 0) {
          return res.json({ kq: 0, errMsg: "Product not found" });
        }

        dataProduct.push(product[0]);

        // console.log(product[0].id)
        // res.render("productDetail", { data: product[0] })
        // res.json(product[0])

        completedRequests++;
        if (completedRequests === orderDetails.length) {
          console.log("xong");
          res.json({ orderDetails: orderDetails, dataProduct: dataProduct });
        }
      });
      // res.render("editorderDetails", { data: orderDetails[0] })
    }
  });
}

function cancelOrder(req, res) {
  console.log(req.params.id);
  let id = req.params.id
  ORDERS.UpdateCancelById(id, 1).then((date) => {
    ORDERS.RefundProductQuantity(id).then((data) => {
      res.json({ success: true })
    })
  }).catch((err) => {
    res.json({ success: false, msg: err })
  })
}

function orderManagement(req, res) {
  ORDERS.find((err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      // console.log(order)
      res.json(order);
    }
  });
}

async function updateOrder(req, res) {
  try {
    const order_id = req.params.id;
    const {
      is_payment,
      is_approved,
      is_being_shipped,
      is_transported,
      is_success,
      is_cancel,
    } = req.body;
    console.log(req.body);
    ORDERS.findByOrderId(order_id, async (err, data) => {
      if (err) {
        return res.json({
          mess: "Cập nhật trạng thái đơn hàng thất bại",
          errDetail: error,
        });
      } else {
        data = data[0];
        console.log(data);
        if (is_payment !== data.is_payment) {
          await ORDERS.UpdatePaymentById(order_id, is_payment);
          console.log("Cập nhật trạng thái thanh toán thành công");
        }

        if (is_approved !== data.is_approved) {
          await ORDERS.UpdateApprovedById(order_id, is_approved);
          console.log("Cập nhật trạng thái đã xác nhận đơn hàng thành công");
        }

        if (is_being_shipped !== data.is_being_shipped) {
          await ORDERS.UpdateShippingById(order_id, is_being_shipped);
          console.log("Cập nhật trạng thái đang giao hàng thành công");
        }

        if (is_transported !== data.is_transported) {
          await ORDERS.UpdateShippedById(order_id, is_transported);
          console.log("Cập nhật trạng thái đã giao hàng thành công");
        }

        if (is_success !== data.is_success) {
          await ORDERS.UpdateSuccessById(order_id, is_success);
          console.log("Cập nhật trạng thái đơn hàng hoàn tất thành công");
        }

        if (is_cancel !== data.is_cancel) {
          await ORDERS.UpdateCancelById(order_id, is_cancel);
          console.log("Cập nhật trạng thái hủy đơn hàng thành công");
        }

        return res.json({ success: true });
      }
    });
  } catch (error) {
    console.error(error);
    res.json({
      mess: "Cập nhật trạng thái đơn hàng thất bại",
      errDetail: error,
    });
  }
}

function orderShipped(req, res) {
  ORDERS.UpdateShippedById(req.params.id, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      res.redirect("../order-management");
    }
  });
  // res.render('editorder')
}

function orderSuccess(req, res) {
  ORDERS.UpdateSuccessById(req.params.id, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      res.redirect("../order-management");
    }
  });
  // res.render('editorder')
}

function orderReject(req, res) {
  ORDERS.UpdateRejectById(req.params.id, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      res.redirect("../order-management");
    }
  });
  // res.render('editorder')
}

function orderShipping(req, res) {
  ORDERS.UpdateShippingById(req.params.id, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      res.redirect("../order-management");
    }
  });
  // res.render('editorder')
}

function reviews(req, res) {
  let token = req.cookies.token;
  let verify = jwt.verify(token, "secretId");
  console.log(req.body);
  let completedRequests = 0;
  req.body.product_id.forEach((productId, i) => {
    const review = new REVIEWS({
      user_id: verify.id,
      product_id: productId,
      rating: req.body.ratings[i],
      comment: req.body.comments[i],
    });

    // console.log(review)
    REVIEWS.create(review, (err, review) => {
      if (!err) {
        completedRequests++;
      }
      if (completedRequests === req.body.product_id.length) {
        res.json({ success: true, redirectUrl: "../order" });
      }
    });
  });
}

async function deleteOrder(req, res) {
  try {
    const orderId = req.body.order_id;

    // Xóa order_details
    await new Promise((resolve, reject) => {
      ORDER_DETAILS.deleteById(orderId, (err, data) => {
        if (err) {
          console.log("Xóa order_detail thất bại - ", err);
          reject(err);
        } else {
          console.log("Xóa order_detail thành công.");
          resolve();
        }
      });
    });

    // Xóa orders
    await new Promise((resolve, reject) => {
      ORDERS.deleteById(orderId, (err, data) => {
        if (err) {
          console.log("Xóa order thất bại - ", err);
          reject(err);
        } else {
          console.log("Xóa order thành công.");
          resolve();
        }
      });
    });

    res.json({ success: true });
  } catch (error) {
    console.error("Lỗi khi xóa order:", error);
    res.status(500).json({ message: "Đã xảy ra lỗi khi xóa order" });
  }
}

function reviewsManagement(req, res) {
  let token = req.cookies.token;
  let verify = jwt.verify(token, "secretId");
  // let userId = verify.id
  // console.log(typeof userId)
  Products.find((err, products) => {
    if (!err) {
      res.render("reviewsManagement", { products: products });
    }
  });
}

function reviewsManagementByProduct(req, res) {
  REVIEWS.findByProductId(req.params.id, (err, reviews) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      // res.render("reviewsManagementByProduct", { reviews: reviews })
      // console.log(reviews)
      res.json(reviews);
    }
  });
}

function deleteReviews(req, res) {
  REVIEWS.deleteById(req.params.id, (err, review) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      res.redirect("../reviews-management");
    }
  });
  // res.render('editProduct')
}

function updateOrderIsRated(req, res) {
  ORDERS.updateOrderIsRatedById(req.params.id, (err, order) => {
    if (err) {
      res.json({ kq: 0, errMsg: err });
    } else {
      // console.log(order[0].id)
      // res.render("editorder", { data: order[0] })
      res.json({ success: true, redirectUrl: "../order" });
    }
  });
  // res.render('editProduct')
}

async function addCategory(req, res) {
  try {

    CATEGORIES.findBySlug(req.body.slug)
      .then((data) => {
        if (data) {
          res.json({ success: false, message: "Mã slug đã tồn tại trong hệ thống" })
          return;
        }

        const newCategory = new CATEGORIES({
          name: req.body.name,
          description: req.body.description,
          slug: req.body.slug
        });

        CATEGORIES.create(newCategory, (err, category) => {
          if (err) {
            res.json({ success: false, message: "Đã xảy ra lỗi khi thêm danh mục" })
            return
          } else {
            res.json({ success: true, message: "Thêm danh mục thành công" })
          }
        })
      })
  } catch (error) {
    console.error(error);
    return res.json({ success: false, message: "Đã xảy ra lỗi trong quá trình xử lý yêu cầu" });
  }
}

async function editCategory(req, res) {
  try {
    const newCategory = new CATEGORIES({
      category_id: req.body.category_id,
      name: req.body.name,
      description: req.body.description,
    });

    CATEGORIES.findById(req.body.category_id).then(() => {
      CATEGORIES.updateByID(newCategory, (err, category) => {
        if (err) {
          console.log(err);
        } else {
          res.json({ success: true, message: "Chỉnh sửa danh mục thành công" });
        }
      });
    });
  } catch (error) {
    console.error(error);
    return res.json({
      success: false,
      message: "Đã xảy ra lỗi trong quá trình xử lý yêu cầu",
    });
  }
}

async function deleteCategory(req, res) {
  try {

    CATEGORIES.deleteById(req.body.category_id, (err, category) => {
      if (err) {
        console.log(err)
      } else {
        if (category) {
          res.json({ success: category, message: 'Xóa danh mục thành công.' })
        } else {
          res.json({ success: category, message: 'Không thể xóa danh mục này.' })
        }

      }
    })

  } catch (error) {
    console.error(error);
    return res.json({ success: false, message: "Đã xảy ra lỗi trong quá trình xử lý yêu cầu" });
  }
}

async function getAllLaptop(req, res) {
  try {
    let page = parseInt(req.query.page);
    let sort = req.query.sort ? req.query.sort : "";
    let limit = req.query.limit ? req.query.limit : 12;
    let brand = req.query.brand ? req.query.brand : "";
    let category = req.query.category ? req.query.category : "";
    let range = req.query.range ? req.query.range : "";

    const reqData = {
      page: page,
      sort: sort,
      limit: limit,
      brand: brand,
      category: category,
      range: range
    };

    if (page) {
      page = page < 1 ? 1 : page;
      Products.getAllWithPaginationAndFilter(reqData, (err, products) => {
        if (err) {
          console.log(err);
          return res.json({ error: "Internal Server Error" });
        } else {
          return res.json(products);
        }
      });
    } else {
      Products.find((err, data) => {
        if (err) console.log(err);
        else {
          res.json(data);
        }
      });
    }
  } catch (error) {
    console.error("Error:", error.message);
    return res.json({ error: "Internal Server Error" });
  }
}

async function searchLaptop(req, res) {
  try {
    let searchKeyword = req.query.q || '';
    let page = req.query.page ? req.query.page : 1;
    let sort = req.query.sort ? req.query.sort : '';
    let limit = req.query.limit ? req.query.limit : 12;

    const reqData = {
      searchKeyword: searchKeyword,
      pageNumber: page,
      limit: limit,
      sort: sort,
    };

    if (page) {
      page = page < 1 ? 1 : page;
      Products.searchProductsWithPagination(reqData, (err, products) => {
        if (err) {
          console.log(err);
          return res.json({ error: "Internal Server Error" });
        } else {
          return res.json(products);
        }
      });
    } else {
      Products.find((err, data) => {
        if (err) console.log(err);
        else {
          res.json(data);
        }
      });
    }
  } catch (error) {
    console.error("Error:", error.message);
    return res.json({ error: "Internal Server Error" });
  }
}

module.exports = {
  home,
  laptopGaming,
  laptopOffice,
  laptopLuxury,
  getLaptopsByQuery,
  listImage,
  management,
  editProduct,
  editProductPost,
  addUser,
  deleteUser,
  editUserManagement,
  editUserInfo,
  editUserInfoPassWord,
  deleteProduct,
  productDetail,
  cart,
  cartServer,
  addCart,
  deleteCart,
  updateCart,
  checkout,
  dataOrder,
  createPaymentVNPAY,
  order,
  orderDetails,
  cancelOrder,
  orderManagement,
  updateOrder,
  orderSuccess,
  orderReject,
  orderShipping,
  orderShipped,
  reviews,
  reviewsManagement,
  reviewsManagementByProduct,
  deleteReviews,
  updateOrderIsRated,
  users,
  deleteOrder,
  deliveryAddress,
  addDeliveryAddress,
  deleteDeliveryAddress,
  userById,
  addCategory,
  editCategory,
  deleteCategory,
  getAllLaptop,
  searchLaptop,
};

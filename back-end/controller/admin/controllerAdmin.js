// const {sql, connect} = require('../../connect');
const IMAGES = require('../../models/images');
const ORDERS = require('../../models/order');
const Products = require('../../models/product');
//multer
var multer = require('multer');
const USERS = require('../../models/user');
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/upload/products/')
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname)
  }
});
var upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    console.log(file);
    if (file.mimetype == "image/bmp" || file.mimetype == "image/png" || file.mimetype == "image/jpeg" || file.mimetype == "image/jpg" || file.mimetype == "image/gif") {
      cb(null, true)
    } else {
      return cb(new Error('Only image are allowed!'))
    }
  }
}).single("avatar");


function controllerAdmin(req, res) {

  Products.find((err, product) => {
    if (!err) {
      console.log(req.session)
      // res.render("management", { data: product })
      res.json(product)
    }
  });
}


function addProducts(req, res) {
  res.render('addProducts')
}

async function newProduct(req, res) {
  try {
    console.log(req.body);
    console.log(req.files.avatar[0]);
    console.log(req.files.images);

    const product = new Products({
      avatar: 'http://localhost:8000/upload/products/' + req.files.avatar[0].filename,
      brand_id: req.body.brand_id,
      category_id: req.body.category_id,
      prod_name: req.body.prod_name,
      prod_description: req.body.prod_description,
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
      graphics: req.body.graphics
    });

    const id = await Products.createWithPromise(product);

    if (req.files.images) {
      console.log('line 78 controller admin', id);
      let listImage = req.files.images;
      await Promise.all(listImage.map(image => {
        const newImage = new IMAGES({
          product_id: id,
          url: 'http://localhost:8000/upload/products/' + image.filename
        });
        return new Promise((resolve, reject) => {
          IMAGES.create(newImage, (err, result) => {
            if (err) {
              reject(err);
            } else {
              resolve(result);
            }
          });
        });
      }));
      res.json({ success: true });
    } else {
      res.json({ success: false, message: "Can not find list images of product" });
    }
  } catch (err) {
    console.error(err);
    res.json({ success: false, message: "Error creating new product" });
  }
}



const getOrderSuccessByDate = (req, res) => {
  let days = parseInt(req.params.days);
  console.log(days);
  ORDERS.findOrderSuccessByDays(days, (err, data) => {
    if (err) {
      console.log('Line 109 - controllerAdmin: ', err);
      res.json({ success: false, err: err })
    } else {
      res.json({ success: true, listOrders: data })

    }
  })
}

const getNewOrderByDate = (req, res) => {
  let days = parseInt(req.params.days);
  console.log(days);
  ORDERS.findNewOrderByDays(days, (err, data) => {
    if (err) {
      console.log('Line 109 - controllerAdmin: ', err);
      res.json({ success: false, err: err })
    } else {
      res.json({ success: true, listOrders: data })

    }
  })
}

const getNewUserByDate = (req, res) => {
  let days = parseInt(req.params.days);
  console.log(days);
  USERS.findNewUserByDays(days, (err, data) => {
    if (err) {
      console.log('Line 109 - controllerAdmin: ', err);
      res.json({ success: false, err: err })
    } else {
      res.json({ success: true, listUsers: data })

    }
  })
}

const getFavoriteBrands = (req, res) => {
  let days = parseInt(req.params.days);
  console.log(days);
  ORDERS.findTotalBrandSuccessfulByDays(days, (err, data) => {
    if (err) {
      console.log('Line 153 - controllerAdmin: ', err);
      res.json({ success: false, err: err })
    } else {
      res.json({ success: true, listFavoriteBrands: data })

    }
  })
}

const getFavoriteLaptops = (req, res) => {
  let days = parseInt(req.params.days);
  console.log(days);
  ORDERS.findTotalLaptopsSuccessfulByDays(days, (err, data) => {
    if (err) {
      console.log('Line 167 - controllerAdmin: ', err);
      res.json({ success: false, err: err })
    } else {
      res.json({ success: true, listFavoriteLaptops: data })

    }
  })
}
module.exports = {
  controllerAdmin, addProducts, newProduct, getOrderSuccessByDate, getNewOrderByDate, getNewUserByDate, getFavoriteBrands, getFavoriteLaptops
}

const CATEGORIES = require('../../models/categories');
const BRANDS = require('../../models/brands');
const { v4: uuidv4 } = require('uuid');
const uuid = uuidv4();
const jwt = require('jsonwebtoken')

function categoriesList(req, res) {
  CATEGORIES.find((err, categories) => {
    if (!err) {
      // res.render("management", { data: product })
      res.json(categories)
    }
    else {
      console.log(err)

    }
  });
  // res.render("categoriesList")
}

function categoriesAddNew(req, res) {
  // USERS.findById
  // console.log(req.body)
  CATEGORIES.find((err, categories) => {
    if (err) {
      res.json({ "kq": 0, "errMsg": err });
    }
    else {
      // console.log(categories[0].id)
      // res.render("editcategories", { data: categories[0] })
      // res.json({data:categories.length})
      if (categories.length == 0) {
        // let category_id = 1;
        const category = new CATEGORIES({
          category_id: 1,
          name: req.body.name,
          description: req.body.description
        });


        // console.log(order)
        CATEGORIES.create(category, (err, category) => {

          if (!err) {

            res.json({ success: true, redirectUrl: '../categories-management' });

          }

        })
      }
    }
  })


}

function brandsList(req, res) {
  BRANDS.find((err, brands) => {
    if (!err) {
      // res.render("management", { data: product })
      res.json(brands)
    }
    else {
      console.log(err)

    }
  });
  // res.render("categoriesList")
}

function brandAddNew(req, res) {

  BRANDS.findBySlug(req.body.slug).then((data) => {
    if (data) {
      res.json({ success: false, message: "Mã slug đã tồn tại trong hệ thống" })
      return;
    }

    const newBrand = new BRANDS({
      name: req.body.name,
      description: req.body.description,
      slug: req.body.slug,
      image: 'http://localhost:8000/upload/brands/' + req.files.avatar[0].filename,
    });

    BRANDS.addNewBrand(newBrand, (err, data) => {
      if (err) {
        res.json({ success: false, message: err });
      }
      else {
        res.json({ success: true, message: 'Thêm thương hiệu thành công.' });
      }
    })
  })
}

function brandEdit(req, res) {
  console.log(req.body);
  let file = ''
  console.log(req.files);
  if (req.files != null && req.files.avatar != null && req.files.avatar.length > 0) {
    file = 'http://localhost:8000/upload/brands/' + req.files.avatar[0].filename
  } else {
    file = req.body.avatar
  }
  BRANDS.editBrandById(req.body, file, (err, brands) => {
    if (err) {
      res.json({ success: false, message: err });
    }
    else {
      res.json({ success: true, message: 'Chỉnh sửa thương hiệu thành công.' });
    }
  })

}

function brandDelete(req, res) {
  BRANDS.deleteById(req.body.brand_id, (err, brands) => {
    if (err) {
      res.json({ success: false, message: err });
    }
    else {
      if (brands) {
        res.json({ success: brands, message: 'Xóa thương hiệu thành công.' });
      } else {
        res.json({ success: brands, message: 'Không thể xóa thương hiệu này.' });
      }
    }
  })
}


module.exports = {
  categoriesList, categoriesAddNew,
  brandAddNew, brandsList, brandEdit, brandDelete
}
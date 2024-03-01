const express = require('express');
const routerCategories = express.Router();
const controllerCategories = require('../controller/Home/categoriesController')
const authMiddleware = require('../middle_ware/auth.middleware');
const multer = require('multer');

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/upload')
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + "-" + file.originalname)
    }
});
const uploadMuti = multer({
    storage,
    fileFilter: (req, file, cb) => {
        if (
            (file.fieldname === 'images' && (file.mimetype === 'image/png' || file.mimetype === 'image/jpg' || file.mimetype === 'image/jpeg')) ||
            (file.fieldname === 'avatar' && (file.mimetype === 'image/png' || file.mimetype === 'image/jpg' || file.mimetype === 'image/jpeg'))
        ) {
            cb(null, true);
        } else {
            cb(null, false);
            const err = new Error('Only .png, .jpg and .jpeg format allowed for images and avatar fields!');
            err.name = 'ExtensionError';
            return cb(err);
        }
    },
    limits: {
        fileSize: 1024 * 1024 * 5, // 5MB limit for each file
    },
    fieldNameSize: 100, // Maximum field name size
    fieldSize: 1024 * 1024 * 5, // Maximum field value size (5MB)
}).fields([
    { name: 'images', maxCount: 8 },
    { name: 'avatar', maxCount: 1 },
]);



routerCategories.get('/categories-list', controllerCategories.categoriesList)
routerCategories.get('/categories/addnew', authMiddleware.isAuthAdmin, controllerCategories.categoriesAddNew)
routerCategories.get('/brands-list', controllerCategories.brandsList)
routerCategories.post('/brands/addnew', uploadMuti, authMiddleware.isAuthAdmin, controllerCategories.brandAddNew)
routerCategories.post('/brands/edit', uploadMuti, authMiddleware.isAuthAdmin, controllerCategories.brandEdit)
routerCategories.post('/brands/delete', authMiddleware.isAuthAdmin, controllerCategories.brandDelete)

module.exports.routerCategories = routerCategories
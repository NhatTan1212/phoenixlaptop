const { sql, connect } = require('../connect');
const Products = require('./product');

const BRANDS = function (brands) {
    this.brand_id = brands.brand_id;
    this.name = brands.name;
    this.description = brands.description;
    this.slug = brands.slug;
    this.image = brands.image
};

BRANDS.create = async (brands, result) => {
    const pool = await connect;
    const sqlStringAddOrder = `
    INSERT INTO BRANDS (brand_id, name, description)
    VALUES (@brand_id, @name, @description)
    `;
    await pool.request()
        .input('brand_id', sql.Int, brands.brand_id)
        .input('name', sql.NVARCHAR(100), brands.name)
        .input('description', sql.NVARCHAR(255), brands.description)
        .query(sqlStringAddOrder, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, { id: data.insertId, ...data });
        })
};

BRANDS.find = async (result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM BRANDS
    `;
    await pool.request()
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
            sql.close();
        })
}

BRANDS.findByProductId = async (brand_id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM BRANDS where brand_id = @brand_id
    `;
    await pool.request()
        .input('brand_id', sql.Int, brand_id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
            sql.close();
        })
}

BRANDS.addNewBrand = async (newBrand, result) => {
    const pool = await connect;
    const sqlStringAddBrand = `
        INSERT INTO BRANDS (name, description, slug, image)
        VALUES (@name, @description, @slug, @image)
    `;
    try {
        await pool.request()
            .input('name', sql.NVARCHAR(100), newBrand.name)
            .input('description', sql.NVARCHAR(255), newBrand.description)
            .input('slug', sql.NVARCHAR(255), newBrand.slug)
            .input('image', sql.NVARCHAR(255), newBrand.image)
            .query(sqlStringAddBrand, (err, data) => {
                if (err) {
                    console.log(err)
                    result(err, null)
                } else {
                    result(null, true);
                }
            })
    } catch (error) {
        console.error('Error in addNewBrand:', error);
        result(error, null);
    } finally {
        sql.close();
    }
}

BRANDS.deleteById = async (brand_id, result) => {
    const pool = await connect;
    try {
        const productsList = await Products.findByBrandId(brand_id);

        if (productsList.length === 0) {
            // Xóa thương hiệu
            await pool.request()
                .input('brand_id', sql.Int, brand_id)
                .query(`DELETE FROM BRANDS WHERE brand_id = @brand_id;`);

            result(null, true);
            sql.close();
            return;
        } else {
            result(null, false);
            return;
        }

        // // Xóa dữ liệu liên quan của từng sản phẩm
        // const deletePromises = productsList.map(async (product) => {
        //     console.log('Product ID: ', product.id);

        //     const deleteImageQuery = pool.request()
        //         .input('product_id', sql.Int, product.id)
        //         .query(`DELETE FROM IMAGES WHERE product_id = @product_id;`);

        //     const deleteCartQuery = pool.request()
        //         .input('product_id', sql.Int, product.id)
        //         .query(`DELETE FROM CARTS WHERE product_id = @product_id;`);

        //     const deleteOrderDetailQuery = pool.request()
        //         .input('product_id', sql.Int, product.id)
        //         .query(`DELETE FROM ORDER_DETAILS WHERE product_id = @product_id;`);

        //     const deleteReviewQuery = pool.request()
        //         .input('product_id', sql.Int, product.id)
        //         .query(`DELETE FROM REVIEWS WHERE product_id = @product_id;`);

        //     // Chờ tất cả các công việc xóa dữ liệu hoàn tất trước khi tiếp tục
        //     await Promise.all([deleteImageQuery, deleteCartQuery, deleteOrderDetailQuery, deleteReviewQuery]);
        // });

        // // Chờ cho tất cả công việc xóa dữ liệu liên quan của các sản phẩm hoàn tất
        // await Promise.all(deletePromises);

        // // Xóa các sản phẩm
        // await pool.request()
        //     .input('brand_id', sql.Int, brand_id)
        //     .query(`DELETE FROM PRODUCTS WHERE brand_id = @brand_id;`);

        // // Xóa thương hiệu
        // await pool.request()
        //     .input('brand_id', sql.Int, brand_id)
        //     .query(`DELETE FROM BRANDS WHERE brand_id = @brand_id;`);

        // result(null, "Successfully deleted brand and related data.");
    } catch (error) {
        console.error('Error in findByBrandId:', error);
        result(error, null);
    } finally {
        sql.close();
    }
};


BRANDS.editBrandById = async (brand, file, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        UPDATE BRANDS SET
        name = @name, 
        description = @description,
        updated_at = CURRENT_TIMESTAMP,
        image = @image
        WHERE brand_id = @brand_id
    `;

    await pool.request()
        .input('brand_id', sql.Int, brand.brand_id)
        .input('name', sql.NVARCHAR(100), brand.name)
        .input('description', sql.NVARCHAR(255), brand.description)
        .input('image', sql.NVARCHAR(255), file)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
                result(err, null)
            } else {

            }
            result(null, 1);
            sql.close();
        })
}

module.exports = BRANDS;
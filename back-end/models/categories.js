const { sql, connect } = require('../connect');
const Products = require('./product');

const CATEGORIES = function (category) {
    this.category_id = category.category_id;
    this.name = category.name;
    this.description = category.description;
    this.slug = category.slug;
};

CATEGORIES.create = async (category, result) => {
    const pool = await connect;
    const sqlStringAddOrder = `
    INSERT INTO CATEGORIES (name, description,slug)
    VALUES (@name, @description,@slug)
    `;
    await pool.request()
        .input('name', sql.NVARCHAR(100), category.name)
        .input('description', sql.NVARCHAR(255), category.description)
        .input('slug', sql.NVARCHAR(255), category.slug)
        .query(sqlStringAddOrder, (err, data) => {
            if (err) {
                result(err, null);
                return;
            }
            result(null, data);
        })
};

CATEGORIES.find = async (result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM CATEGORIES
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

CATEGORIES.findById = async (id) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
                SELECT * FROM CATEGORIES WHERE category_id = @id
            `;
            const result = await pool.request()
                .input('id', sql.Int, id)
                .query(sqlStringAddProduct);

            resolve(result.recordset);
        } catch (error) {
            reject(error);
        }
    });
};

CATEGORIES.deleteById = async (category_id, result) => {
    const pool = await connect;
    try {
        const productsList = await Products.findByCategoryIdPromise(category_id);

        if (!productsList) {
            // Xóa danh mục
            await pool.request()
                .input('category_id', sql.Int, category_id)
                .query(`DELETE FROM CATEGORIES WHERE category_id = @category_id;`);

            result(null, "Successfully deleted categories and related data.");
            sql.close();
            return;
        }

        // Xóa dữ liệu liên quan của từng sản phẩm
        const deletePromises = productsList.map(async (product) => {
            console.log('Product ID: ', product.id);

            const deleteImageQuery = pool.request()
                .input('product_id', sql.Int, product.id)
                .query(`DELETE FROM IMAGES WHERE product_id = @product_id;`);

            const deleteCartQuery = pool.request()
                .input('product_id', sql.Int, product.id)
                .query(`DELETE FROM CARTS WHERE product_id = @product_id;`);

            const deleteOrderDetailQuery = pool.request()
                .input('product_id', sql.Int, product.id)
                .query(`DELETE FROM ORDER_DETAILS WHERE product_id = @product_id;`);

            const deleteReviewQuery = pool.request()
                .input('product_id', sql.Int, product.id)
                .query(`DELETE FROM REVIEWS WHERE product_id = @product_id;`);

            // Chờ tất cả các công việc xóa dữ liệu hoàn tất trước khi tiếp tục
            await Promise.all([deleteImageQuery, deleteCartQuery, deleteOrderDetailQuery, deleteReviewQuery]);
        });

        // Chờ cho tất cả công việc xóa dữ liệu liên quan của các sản phẩm hoàn tất
        await Promise.all(deletePromises);

        // Xóa các sản phẩm
        await pool.request()
            .input('category_id', sql.Int, category_id)
            .query(`DELETE FROM PRODUCTS WHERE category_id = @category_id;`);

        // Xóa danh mục
        await pool.request()
            .input('category_id', sql.Int, category_id)
            .query(`DELETE FROM CATEGORIES WHERE category_id = @category_id;`);

        result(null, "Successfully deleted categories and related data.");
    } catch (error) {
        console.error('Error in findByCategoryId:', error);
        result(error, null);
    } finally {
        sql.close();
    }
}

CATEGORIES.updateByID = async (new_category, result) => {
    const pool = await connect;
    const sqlStringUpdateCategory = `
        UPDATE CATEGORIES
        SET
            name = @name,
            description = @description,
            updated_at = CURRENT_TIMESTAMP
        WHERE category_id = @category_id
        `
    await pool.request()
        .input('category_id', sql.INT, new_category.category_id)
        .input('name', sql.NVARCHAR(100), new_category.name)
        .input('description', sql.NVARCHAR(255), new_category.description)
        .query(sqlStringUpdateCategory, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                result(null, { "message": "success", "data": data });
            }
            sql.close();
        })
}

module.exports = CATEGORIES;
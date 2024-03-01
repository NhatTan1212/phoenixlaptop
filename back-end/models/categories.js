const { sql, connect } = require('../connect');

const CATEGORIES = function (category) {
    this.category_id = category.category_id;
    this.name = category.name;
    this.description = category.description;
};

CATEGORIES.create = async (category, result) => {
    const pool = await connect;
    const sqlStringAddOrder = `
    INSERT INTO CATEGORIES (name, description)
    VALUES (@name, @description)
    `;
    await pool.request()
        .input('name', sql.NVARCHAR(100), category.name)
        .input('description', sql.NVARCHAR(255), category.description)
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
    const sqlStringAddProduct = `
        DELETE FROM CATEGORIES
        WHERE category_id = @category_id;
    `;
    await pool.request()
        .input('category_id', sql.Int, category_id)
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
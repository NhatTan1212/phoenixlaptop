const { sql, connect } = require('../connect');

const DELIVERY_ADDRESS = function (delivery_address) {
    this.user_id = delivery_address.user_id;
    this.province = delivery_address.province;
    this.district = delivery_address.district;
    this.ward = delivery_address.ward;
    this.detail_address = delivery_address.detail_address;


};

DELIVERY_ADDRESS.create = async (delivery_address, result) => {
    const pool = await connect;
    const sqlStringAddOrder = `
    INSERT INTO DELIVERY_ADDRESS VALUES (@user_id, @detail_address,@province,@district,@ward);
    `;
    await pool.request()
        .input('user_id', sql.Int, delivery_address.user_id)
        .input('detail_address', sql.NVARCHAR(100), delivery_address.detail_address)
        .input('province', sql.NVARCHAR(50), delivery_address.province)
        .input('district', sql.NVARCHAR(50), delivery_address.district)
        .input('ward', sql.NVARCHAR(50), delivery_address.ward)
        .query(sqlStringAddOrder, (err, data) => {
            if (err) {
                console.log(err)
                result(err, null)
            } else {
                result(null, data)
            }
            sql.close()
        })
};

DELIVERY_ADDRESS.findByUserId = async (user_id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM DELIVERY_ADDRESS where user_id = @user_id
    `;
    await pool.request()
        .input('user_id', sql.Int, user_id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
            sql.close()
        })
}

DELIVERY_ADDRESS.deleteById = async (user_id, address_id, result) => {
    const pool = await connect;
    const sqlStringDeleteProduct = `
        DELETE FROM DELIVERY_ADDRESS
        WHERE 
        (
            user_id = @user_id AND @user_id IS NOT NULL
        )
        AND id = @address_id
    `;

    try {
        console.log(user_id);
        const request = pool.request()
            .input('user_id', sql.Int, user_id)
            .input('address_id', sql.Int, address_id);

        await request.query(sqlStringDeleteProduct);
        console.log('Success');
        result(null, { "message": "success" });
    } catch (err) {
        console.error(err);
        result(err, null);
    } finally {
        sql.close();
    }
};

module.exports = DELIVERY_ADDRESS;
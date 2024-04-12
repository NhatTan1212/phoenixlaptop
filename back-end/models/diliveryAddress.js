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
                const sqlStringquerylast = `
                    SELECT id
                    FROM DELIVERY_ADDRESS
                    WHERE 
                        user_id = @user_id AND
                        detail_address = @detail_address AND
                        province = @province AND
                        district = @district AND
                        ward = @ward
                `;

                const request = pool.request();
                request.input('user_id', sql.Int, delivery_address.user_id)
                request.input('detail_address', sql.NVARCHAR(100), delivery_address.detail_address)
                request.input('province', sql.NVARCHAR(50), delivery_address.province)
                request.input('district', sql.NVARCHAR(50), delivery_address.district)
                request.input('ward', sql.NVARCHAR(50), delivery_address.ward)

                request.query(sqlStringquerylast, (err, data) => {
                    if (err) {
                        console.log(err);
                        result(err, null);
                    } else {
                        if (data.recordset.length > 0) {
                            console.log('>> Retrieved address_id:', data.recordset[0]);
                            result(null, data.recordset[0].id);
                        } else {
                            console.log('>> Address not found');
                            result('Address not found', null);
                        }
                    }
                });
            }
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
                console.log('76 deliveryaddress', data)
                result(null, data.recordset);
            }
            sql.close()
        })
}

DELIVERY_ADDRESS.findByAddressId = async (address_id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM DELIVERY_ADDRESS where id = @address_id
    `;
    await pool.request()
        .input('address_id', sql.Int, address_id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset[0]);
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
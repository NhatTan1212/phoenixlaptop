const { sql, connect } = require('../connect');

const USERS = function (user) {
    this.id = user.id;
    this.name = user.name;
    this.password = user.password;
    this.email = user.email;
    this.role = user.role;
    this.registrationToken = user.registrationToken;
};

USERS.find = async (result) => {
    const pool = await connect;
    const sqlStringAdduser = `
        select * FROM USERS
    `;
    await pool.request()
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
        })
}

USERS.findLast = async (result) => {
    const pool = await connect;
    const sqlStringAdduser = `
        SELECT TOP 1 * FROM USERS ORDER BY id DESC;
    `;
    await pool.request()
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset[0]);
        })
}



USERS.findById = async (id) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringFindById = `
            SELECT * FROM USERS WHERE id = @id
            `;
            const result = await pool.request()
                .input('id', sql.Int, id)
                .query(sqlStringFindById);

            resolve(result.recordset[0]);
        } catch (error) {
            console.log(error);
            reject(error);
        }
    });
};

USERS.findByEmail = async (email, result) => {

    const pool = await connect;
    const sqlStringAdduser = `
        select * FROM USERS where email = @email
    `;
    await pool.request()
        .input('email', sql.NVARCHAR(100), email)
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            }
            //  else if (data.recordset.length) {
            //     result(null, data.recordset[0])
            //     return;
            // }
            else {
                // console.log(data)
                result(null, data.recordset[0]);
            }
        })
}

USERS.findByIdProvider = async (id, provider, result) => {

    const pool = await connect;
    const sqlStringAdduser = `
        select * FROM USERS where id = @id and provider = @provider
    `;
    await pool.request()
        .input('id', sql.NVARCHAR(100), id)
        .input('provider', sql.NVARCHAR(255), provider)
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            }
            //  else if (data.recordset.length) {
            //     result(null, data.recordset[0])
            //     return;
            // }
            else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

USERS.resetPassword = async (email, password, result) => {
    const pool = await connect;
    const sqlStringAdduser = `
        UPDATE USERS SET password = @password WHERE email = @email
    `;
    await pool.request()
        .input('email', sql.NVARCHAR(100), email)
        .input('password', sql.VARCHAR(255), password)
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            }
            //  else if (data.recordset.length) {
            //     result(null, data.recordset[0])
            //     return;
            // }
            else {
                // console.log(data)
                result(null, { email: email });
            }
        })
};

USERS.resetPasswordById = async (id, password, result) => {
    const pool = await connect;
    const sqlStringAdduser = `
        UPDATE USERS SET password = @password WHERE id = @id
    `;
    await pool.request()
        .input('id', sql.Int, id)
        .input('password', sql.VARCHAR(255), password)
        .query(sqlStringAdduser, (err, data) => {
            if (err) {
                console.log(err)
            }
            else {
                result(null, "success");
            }
            sql.close();
        })

};

USERS.addNewUser = async (newUser, result) => {
    const pool = await connect;
    const sqlStringAddUser = `
        insert into USERS(name, password, email, role, confirmation_status) 
        values( @name, @password, @email, @role, 1)
    `;
    await pool.request()
        .input('name', sql.NVARCHAR(100), newUser.name)
        .input('password', sql.VARCHAR(255), newUser.password)
        .input('email', sql.VARCHAR(100), newUser.email)
        .input('role', sql.NVARCHAR(50), newUser.role)
        .query(sqlStringAddUser, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
            sql.close();
        })
}

USERS.deleteByUserId = async (id, result) => {
    const pool = await connect;
    try {
        await pool.request()
            .input('id', sql.Int, id)
            // Xóa từ bảng REVIEWS sử dụng user_id
            .query(`
                DELETE FROM REVIEWS
                WHERE user_id = @id;
            `);

        await pool.request()
            .input('id', sql.Int, id)
            // Xóa từ bảng PROVIDED_USERS sử dụng user_id
            .query(`
                DELETE FROM PROVIDED_USERS
                WHERE user_id = @id;
            `);

        await pool.request()
            .input('id', sql.Int, id)
            // Xóa từ bảng CARTS sử dụng user_id
            .query(`
                DELETE FROM CARTS
                WHERE user_id = @id;
            `);

        await pool.request()
            .input('id', sql.Int, id)
            // Xóa từ bảng ORDER_DETAILS sử dụng order_id
            .query(`
                DELETE FROM ORDER_DETAILS
                WHERE order_id IN (
                    SELECT id
                    FROM ORDERS
                    WHERE user_id = @id
                );
            `);

        await pool.request()
            .input('id', sql.Int, id)
            // Xóa từ bảng ORDERS sử dụng user_id
            .query(`
                DELETE FROM ORDERS
                WHERE user_id = @id;
            `);

        await pool.request()
            .input('id', sql.Int, id)
            // Cuối cùng, xóa từ bảng USERS sử dụng id
            .query(`
                DELETE FROM USERS
                WHERE id = @id;
            `);

        result(null, "Successfully deleted user and related data.");
    } catch (err) {
        console.log(err);
        result(err, null);
    } finally {
        sql.close();
    }
}

// USERS.deleteByUserId = async (id, result) => {
//     const pool = await connect;
//     const sqlStringDeleteUser = `
//         DELETE FROM USERS
//         WHERE id = @id;
//     `;
//     await pool.request()
//         .input('id', sql.Int, id)
//         .query(sqlStringDeleteUser, (err, data) => {
//             if (err) {
//                 console.log(err)
//             } else {
//                 // console.log(data)
//             }
//             result(null, data);
//             sql.close();
//         })
// }

USERS.editByUserId = async (editUser, result) => {
    const pool = await connect;
    const sqlStringAddUser = `
        UPDATE USERS SET name = @name, password = @password, role = @role WHERE id = @id
    `;
    await pool.request()
        .input('name', sql.NVARCHAR(100), editUser.name)
        .input('password', sql.VARCHAR(255), editUser.password)
        .input('role', sql.NVARCHAR(50), editUser.role)
        .input('id', sql.Int, editUser.id)
        .query(sqlStringAddUser, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
            sql.close();
        })
}

USERS.editUserInfoByUserId = async (editUserInfo, result) => {
    const pool = await connect;
    const sqlStringAddUser = `
        UPDATE USERS SET name = @name, phone = @phone WHERE id = @id
    `;
    await pool.request()
        .input('name', sql.NVARCHAR(100), editUserInfo.name)
        .input('phone', sql.VARCHAR(15), editUserInfo.phone)
        .input('id', sql.Int, editUserInfo.id)
        .query(sqlStringAddUser, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
            }
            result(null, data.recordset);
            sql.close();
        })
}


module.exports = USERS;
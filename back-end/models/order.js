const { sql, connect } = require('../connect');

const ORDERS = function (order) {
    this.user_id = order.user_id;
    this.paymentMethods = order.paymentMethods;
    this.quantity = order.quantity;
    this.total_product = order.total_product;
    this.total = order.total;
    this.avatar = order.avatar;
    this.prod_name = order.prod_name;
    this.name = order.name;
    this.note = order.note;
    this.guest_id = order.guest_id;
    this.email = order.email;
    this.user_address = order.user_address;
    this.phone = order.phone;
    this.trading_code = order.trading_code;
    this.is_payment = order.is_payment;
    this.is_approved = order.is_approved;
    this.is_being_shipped = order.is_being_shipped;
    this.is_transported = order.is_transported;
    this.is_success = order.is_success;
    this.is_cancel = order.is_cancel;
    this.paid_at = order.paid_at;
    this.approved_at = order.approved_at;
    this.being_shipped_at = order.being_shipped_at;
    this.transported_at = order.transported_at;
    this.successful_at = order.successful_at;
    this.cancel_at = order.cancel_at;
    this.vnp_BankCode = order.vnp_BankCode;
    this.vnp_CardType = order.vnp_CardType;
    this.vnp_OrderInfo = order.vnp_OrderInfo;
    this.vnp_PayDate = order.vnp_PayDate;
    this.vnp_TransactionNo = order.vnp_TransactionNo;


};

ORDERS.create = async (order, result) => {
    const pool = await connect;
    const sqlStringAddOrder = `
    INSERT INTO ORDERS (paymentMethods, guest_id, avatar, prod_name, note, quantity,total_product, total, user_id, name, email, user_address, phone, trading_code, 
                        is_payment, is_approved, is_being_shipped, is_transported, is_success, vnp_BankCode, vnp_CardType, vnp_OrderInfo, 
                        vnp_PayDate, vnp_TransactionNo, created_at, updated_at)
    VALUES (@paymentMethods,@guest_id, @avatar, @prod_name, @note, @quantity,@total_product, @total, @user_id, @name, @email, @user_address, @phone, @trading_code, 
                        @is_payment, @is_approved, @is_being_shipped, @is_transported, @is_success, @vnp_BankCode, @vnp_CardType, @vnp_OrderInfo, 
                        @vnp_PayDate, @vnp_TransactionNo, GETDATE(), GETDATE());
    `;
    await pool.request()
        .input('paymentMethods', sql.VARCHAR(255), order.paymentMethods)
        .input('guest_id', sql.VARCHAR(50), order.guest_id)
        .input('avatar', sql.NVARCHAR(255), order.avatar)
        .input('prod_name', sql.NVARCHAR(255), order.prod_name)
        .input('note', sql.NVARCHAR(255), order.note)
        .input('quantity', sql.Int, order.quantity)
        .input('total_product', sql.Int, order.total_product)
        .input('total', sql.Float, order.total)
        .input('user_id', sql.Int, order.user_id)
        .input('name', sql.NVARCHAR(100), order.name)
        .input('email', sql.VARCHAR(100), order.email)
        .input('user_address', sql.NVARCHAR(255), order.user_address)
        .input('phone', sql.NVARCHAR(255), order.phone)
        .input('trading_code', sql.VARCHAR(255), order.trading_code)
        .input('is_payment', sql.Int, order.is_payment)
        .input('is_approved', sql.Int, order.is_approved)
        .input('is_being_shipped', sql.Int, order.is_being_shipped)
        .input('is_transported', sql.Int, order.is_transported)
        .input('is_success', sql.Int, order.is_success)
        .input('vnp_BankCode', sql.VARCHAR(50), order.vnp_BankCode)
        .input('vnp_CardType', sql.VARCHAR(50), order.vnp_CardType)
        .input('vnp_OrderInfo', sql.VARCHAR(50), order.vnp_OrderInfo)
        .input('vnp_PayDate', sql.VARCHAR(50), order.vnp_PayDate)
        .input('vnp_TransactionNo', sql.VARCHAR(50), order.vnp_TransactionNo)
        .query(sqlStringAddOrder, (err, data) => {
            if (err) {
                console.log(err)
            }
            const sqlStringSelectLastInsertedId =
                `
                SELECT *
                FROM ORDERS
                WHERE id = (SELECT MAX(id) FROM ORDERS);
            `;
            pool.request().query(sqlStringSelectLastInsertedId, (err, data) => {
                if (err) {
                    console.log(err);
                    result(err, null);
                } else {
                    const lastId = data.recordset[0].id;
                    console.log('line82: order.js - LastId: ', lastId)
                    if (order.vnp_PayDate) {
                        new Promise(async (resolve, reject) => {
                            try {
                                console.log('order.vnp_PayDate = ', order.vnp_PayDate);
                                const sqlStringAddProduct = `
                                UPDATE ORDERS
                                SET is_payment = 1,
                                paid_at = '${order.vnp_PayDate}'
                                WHERE id = @id;
                                `;

                                const data = await pool.request()
                                    .input('id', sql.Int, lastId)
                                    .query(sqlStringAddProduct);

                                resolve(data.recordset);
                            } catch (err) {
                                console.log(err);
                                reject(err);
                            }
                        })
                        result(null, { id: lastId });
                    } else {
                        result(null, lastId)
                    }
                }
            });
        })
};


ORDERS.find = async (result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM ORDERS order by id desc
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

ORDERS.findById = async (user_id, guest_id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM ORDERS where user_id = @user_id or guest_id = @guest_id order by id desc
    `;
    await pool.request()
        .input('user_id', sql.Int, user_id)
        .input('guest_id', sql.VARCHAR(50), guest_id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.findTotalBrandSuccessfulByDays = async (days, result) => {
    const pool = await connect;
    const sqlString = `
            SELECT 
                P.brand_id,
                B.name,
                SUM(OD.quantity) AS total_success_products
            FROM 
                ORDERS O 
                JOIN ORDER_DETAILS OD ON O.id = OD.order_id 
                JOIN PRODUCTS P ON OD.product_id = P.id 
                JOIN BRANDS B ON P.brand_id = B.brand_id
            WHERE 
                O.is_success = 1 and O.successful_at <= GETDATE() and successful_at >= DATEADD(day,-@days,GETDATE())
            GROUP BY 
                P.brand_id,B.name
            ORDER BY 
                total_success_products DESC;
    `;
    await pool.request()
        .input('days', sql.Int, days)
        .query(sqlString, (err, data) => {
            if (err) {
                console.log(err)
                result(err, null)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.findTotalLaptopsSuccessfulByDays = async (days, result) => {
    const pool = await connect;
    const sqlString = `
            SELECT
            P.avatar,
                P.prod_name,
                SUM(OD.quantity)as quantity_sold, 
                OD.price,
                P.quantity as stock
            FROM 
                ORDERS O 
                JOIN ORDER_DETAILS OD ON O.id = OD.order_id 
                JOIN PRODUCTS P ON OD.product_id = P.id 
            WHERE 
                O.is_success = 1 and O.successful_at <= GETDATE() and successful_at >= DATEADD(day,-@days,GETDATE())
            Group By 
            P.avatar,
            P.prod_name,
                OD.price,
                P.quantity
                Order by quantity_sold desc
    `;
    await pool.request()
        .input('days', sql.Int, days)
        .query(sqlString, (err, data) => {
            if (err) {
                console.log(err)
                result(err, null)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.findOrderSuccessByDays = async (days, result) => {
    const pool = await connect;
    const resData = {};

    const sqlString1 = `
        SELECT *
        FROM ORDERS
        WHERE is_success = 1
        AND successful_at >= DATEADD(day, -@days+1, GETDATE())
        AND successful_at <= GETDATE();
    `;

    const getOrderCurrent = new Promise((resolve, reject) => {
        pool.request()
            .input('days', sql.Int, days)
            .query(sqlString1, (err, data) => {
                if (err) {
                    console.log(err);
                    reject(err);
                } else {
                    resData["daysCurrent"] = data.recordset;
                    resolve();
                }
            });
    });

    const sqlString2 = `
        SELECT *
        FROM ORDERS
        WHERE is_success = 1
        AND successful_at >= DATEADD(day, -@days*2+1, GETDATE())
        AND successful_at <= DATEADD(day, -@days+1, GETDATE());
    `;

    const getOrderBefore = new Promise((resolve, reject) => {
        pool.request()
            .input('days', sql.Int, days)
            .query(sqlString2, (err, data) => {
                if (err) {
                    console.log(err);
                    reject(err);
                } else {
                    resData["daysBefore"] = data.recordset;
                    resolve();
                }
            });
    });

    try {
        await Promise.all([getOrderCurrent, getOrderBefore]);
        result(null, resData);
    } catch (error) {
        result(error, null);
    }
};

ORDERS.findNewOrderByDays = async (days, result) => {
    const pool = await connect;
    const resData = {};

    const sqlString1 = `
        SELECT *
        FROM ORDERS
        WHERE created_at >= DATEADD(day, -@days+1, GETDATE())
        AND created_at <= GETDATE();
    `;

    const getOrderCurrent = new Promise((resolve, reject) => {
        pool.request()
            .input('days', sql.Int, days)
            .query(sqlString1, (err, data) => {
                if (err) {
                    console.log(err);
                    reject(err);
                } else {
                    resData["daysCurrent"] = data.recordset;
                    resolve();
                }
            });
    });

    const sqlString2 = `
        SELECT *
        FROM ORDERS
        WHERE created_at >= DATEADD(day, -@days*2+1, GETDATE())
        AND created_at <= DATEADD(day, -@days+1, GETDATE());
    `;

    const getOrderBefore = new Promise((resolve, reject) => {
        pool.request()
            .input('days', sql.Int, days)
            .query(sqlString2, (err, data) => {
                if (err) {
                    console.log(err);
                    reject(err);
                } else {
                    resData["daysBefore"] = data.recordset;
                    resolve();
                }
            });
    });

    try {
        await Promise.all([getOrderCurrent, getOrderBefore]);
        result(null, resData);
    } catch (error) {
        result(error, null);
    }
};


ORDERS.findByVnpTransactionNo = async (vnp_TransactionNo, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM ORDERS where vnp_TransactionNo = @vnp_TransactionNo
    `;
    await pool.request()
        .input('vnp_TransactionNo', sql.VARCHAR(50), vnp_TransactionNo)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                result(null, data.recordset);
            }
        })
}
ORDERS.findByOrderId = async (order_id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM ORDERS where id = @order_id
    `;
    await pool.request()
        .input('order_id', sql.Int, order_id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.selectLast = async (result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        SELECT *
        FROM ORDERS
        WHERE id = (SELECT MAX(id) FROM ORDERS);
    `;
    await pool.request()
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.UpdateOrder = async (id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
    UPDATE ORDERS
    SET is_payment = @is_payment,
    is_approved = @is_approved,
    is_being_shipped = @is_being_shipped,
    is_transported = @is_transported,
    is_success = @is_success,
    WHERE id = @id;
    `;
    await pool.request()
        .input('id', sql.Int, id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}
ORDERS.UpdateApprovedById = async (id, is_approved) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_approved = @is_approved,
            approved_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_approved', sql.Int, is_approved)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdatePaymentById = async (id, is_payment) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_payment = @is_payment,
            paid_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_payment', sql.Int, is_payment)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdateShippedById = async (id, is_transported) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_transported = @is_transported,
            transported_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_transported', sql.Int, is_transported)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdateShippingById = async (id, is_being_shipped) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_being_shipped = @is_being_shipped,
            being_shipped_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_being_shipped', sql.Int, is_being_shipped)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdateSuccessById = async (id, is_success) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_success = @is_success,
            successful_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_success', sql.Int, is_success)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdateCancelById = async (id, is_cancel) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
            UPDATE ORDERS
            SET is_cancel = @is_cancel,
            cancel_at = CURRENT_TIMESTAMP
            WHERE id = @id;
            `;

            const data = await pool.request()
                .input('id', sql.Int, id)
                .input('is_cancel', sql.Int, is_cancel)
                .query(sqlStringAddProduct);

            resolve(data.recordset);
        } catch (err) {
            console.log(err);
            reject(err);
        }
    });
}

ORDERS.UpdateRejectById = async (id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
    UPDATE ORDERS
    SET is_success = 2
    WHERE id = @id;
    `;
    await pool.request()
        .input('id', sql.Int, id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.updateOrderIsRatedById = async (id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
    UPDATE ORDERS
    SET is_rated = 1
    WHERE id = @id;
    `;
    await pool.request()
        .input('id', sql.Int, id)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log(data)
                result(null, data.recordset);
            }
        })
}

ORDERS.deleteById = async (id, result) => {
    const pool = await connect
    sqlString = 'delete from ORDERS Where id = @id'
    await pool.request()
        .input('id', sql.Int, id)
        .query(sqlString, (err, data) => {
            if (err) {
                console.log(err);
                result(err, null)
            } else {
                result(null, data.recordset)
                sql.close()
            }
        })
}



module.exports = ORDERS;
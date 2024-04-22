const { sql, connect } = require('../connect');

const Products = function (product) {
    this.prod_name = product.prod_name;
    this.avatar = product.avatar;
    this.brand_id = product.brand_id;
    this.category_id = product.category_id;
    this.prod_description = product.prod_description;
    this.detailed_evaluation = product.detailed_evaluation;
    this.manufacturer = product.manufacturer;
    this.price = product.price;
    this.cost = product.cost;
    this.quantity = product.quantity;
    this.prod_percent = product.prod_percent;
    this.cpu = product.cpu;
    this.hard_drive = product.hard_drive;
    this.ram = product.ram;
    this.mux_switch = product.mux_switch;
    this.screen = product.screen;
    this.webcam = product.webcam;
    this.connection = product.connection;
    this.prod_weight = product.prod_weight;
    this.pin = product.pin;
    this.operation_system = product.operation_system;
    this.graphics = product.graphics;
    this.on_board = product.on_board;

};

Products.create = async (newproduct, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
    insert into PRODUCTS(prod_name,avatar, brand_id, category_id,prod_description,manufacturer,price,cost,quantity,prod_percent,cpu,
                            hard_drive,ram,mux_switch,screen,webcam,connection,prod_weight,pin,operation_system,graphics) 
    values( @prod_name,@avatar,@brand_id,@category_id,@prod_description,@manufacturer,@price,@cost,@quantity,@prod_percent,@cpu,
            @hard_drive,@ram,@mux_switch,@screen,@webcam,@connection,@prod_weight,@pin,@operation_system,@graphics)
    `;
    await pool.request()
        .input('prod_name', sql.NVARCHAR(255), newproduct.prod_name)
        .input('avatar', sql.VARCHAR(255), newproduct.avatar)
        .input('brand_id', sql.INT, newproduct.brand_id)
        .input('category_id', sql.INT, newproduct.category_id)
        .input('prod_description', sql.NVARCHAR(sql.MAX), newproduct.prod_description)
        .input('manufacturer', sql.NVARCHAR(255), newproduct.manufacturer)
        .input('price', sql.FLOAT, newproduct.price)
        .input('cost', sql.FLOAT, newproduct.cost)
        .input('quantity', sql.INT, newproduct.quantity)
        .input('prod_percent', sql.FLOAT, newproduct.prod_percent)
        .input('cpu', sql.NVARCHAR(255), newproduct.cpu)
        .input('hard_drive', sql.NVARCHAR(255), newproduct.hard_drive)
        .input('ram', sql.NVARCHAR(255), newproduct.ram)
        .input('mux_switch', sql.NVARCHAR(255), newproduct.mux_switch)
        .input('screen', sql.NVARCHAR(255), newproduct.screen)
        .input('webcam', sql.NVARCHAR(255), newproduct.webcam)
        .input('connection', sql.NVARCHAR(255), newproduct.connection)
        .input('prod_weight', sql.NVARCHAR(255), newproduct.prod_weight)
        .input('pin', sql.NVARCHAR(255), newproduct.pin)
        .input('operation_system', sql.NVARCHAR(255), newproduct.operation_system)
        .input('graphics', sql.NVARCHAR(255), newproduct.graphics)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                console.log('success')
            }
            result(null, { id: data.insertId, ...newproduct });
            sql.close();
        })
};
Products.createWithPromise = async (newproduct, result) => {
    try {
        const pool = await connect;
        const sqlStringAddProduct = `
            INSERT INTO PRODUCTS(prod_name, avatar, brand_id, category_id, prod_description, manufacturer, price, cost, quantity, prod_percent, cpu,
                                hard_drive, ram, mux_switch, screen, webcam, connection, prod_weight, pin, operation_system, graphics) 
            VALUES (@prod_name, @avatar, @brand_id, @category_id, @prod_description, @manufacturer, @price, @cost, @quantity, @prod_percent, @cpu,
                    @hard_drive, @ram, @mux_switch, @screen, @webcam, @connection, @prod_weight, @pin, @operation_system, @graphics);
        `;
        const data = await pool.request()
            .input('prod_name', sql.NVARCHAR(255), newproduct.prod_name)
            .input('avatar', sql.VARCHAR(255), newproduct.avatar)
            .input('brand_id', sql.INT, newproduct.brand_id)
            .input('category_id', sql.INT, newproduct.category_id)
            .input('prod_description', sql.NVARCHAR(sql.MAX), newproduct.prod_description)
            .input('manufacturer', sql.NVARCHAR(255), newproduct.manufacturer)
            .input('price', sql.FLOAT, newproduct.price)
            .input('cost', sql.FLOAT, newproduct.cost)
            .input('quantity', sql.INT, newproduct.quantity)
            .input('prod_percent', sql.FLOAT, newproduct.prod_percent)
            .input('cpu', sql.NVARCHAR(255), newproduct.cpu)
            .input('hard_drive', sql.NVARCHAR(255), newproduct.hard_drive)
            .input('ram', sql.NVARCHAR(255), newproduct.ram)
            .input('mux_switch', sql.NVARCHAR(255), newproduct.mux_switch)
            .input('screen', sql.NVARCHAR(255), newproduct.screen)
            .input('webcam', sql.NVARCHAR(255), newproduct.webcam)
            .input('connection', sql.NVARCHAR(255), newproduct.connection)
            .input('prod_weight', sql.NVARCHAR(255), newproduct.prod_weight)
            .input('pin', sql.NVARCHAR(255), newproduct.pin)
            .input('operation_system', sql.NVARCHAR(255), newproduct.operation_system)
            .input('graphics', sql.NVARCHAR(255), newproduct.graphics)
            .query(sqlStringAddProduct);

        const sqlStringSelectLastProduct = `
            SELECT *
            FROM PRODUCTS
            WHERE id = (SELECT MAX(id) FROM PRODUCTS);
        `;
        const dataLastProduct = await pool.request().query(sqlStringSelectLastProduct);
        console.log('line 109 product.js', dataLastProduct);
        if (dataLastProduct.recordset.length > 0) {
            return dataLastProduct.recordset[0].id;
        } else {
            throw new Error('No product found.');
        }
    } catch (error) {
        console.error("Error when create new product! Error Details: ", error);
        throw error;
    }
};



Products.selectLast = async () => {
    const pool = await connect;
    const sqlStringAddProduct = `
        SELECT *
        FROM PRODUCTS
        WHERE id = (SELECT MAX(id) FROM PRODUCTS);
    `;
    const data = await pool.request().query(sqlStringAddProduct);
    if (data.recordset.length > 0) {
        return data.recordset[0].id;
    } else {
        throw new Error('No product found.');
    }
}


Products.updateDecreaseQuantityById = async (id, count, result) => {
    const pool = await connect;
    const sqlStringUpdateDecreaseQuantityById = `
    update PRODUCTS SET quantity = quantity-@count where id=@id and quantity-@count>=0
    `;
    await pool.request()
        .input('id', sql.Int, id)
        .input('count', sql.Int, count)
        .query(sqlStringUpdateDecreaseQuantityById, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                // console.log('id: ', data.recordset)
                result(null, data.recordset);
            }
        })
}


Products.find = async (result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM PRODUCTS order by id desc
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


// Products.findById = async (id, result) => {
//     const pool = await connect;
//     const sqlStringAddProduct = `
//         select * FROM PRODUCTS where id = @id
//     `;
//     await pool.request()
//         .input('id', sql.Int, id)
//         .query(sqlStringAddProduct, (err, data) => {
//             if (err) {
//                 console.log(err)
//             } else {
//                 // console.log(data)
//                 result(null, data.recordset);
//             }
//             sql.close();
//         })
// }
Products.findById = async (id) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
                SELECT * FROM PRODUCTS WHERE id = @id 
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

Products.findByBrandId = async (id) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
                SELECT * FROM PRODUCTS WHERE brand_id = @id order by id desc
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

Products.findByCategoryIdPromise = async (category_id) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            const sqlStringAddProduct = `
                SELECT * FROM PRODUCTS WHERE category_id = @category_id
            `;
            const result = await pool.request()
                .input('category_id', sql.Int, category_id)
                .query(sqlStringAddProduct);

            resolve(result.recordset);
        } catch (error) {
            reject(error);
        }
    });
};

Products.findByQuery = async (slugBrand, slugCategory, sort) => {
    return new Promise(async (resolve, reject) => {
        try {
            const pool = await connect;
            let sqlStringAddProduct = `
                SELECT * FROM PRODUCTS
            `;

            if (slugBrand !== undefined) {
                sqlStringAddProduct += `WHERE brand_id IN (SELECT brand_id FROM BRANDS WHERE slug IN (${slugBrand}))`;
            }

            if (slugCategory !== undefined) {
                if (slugBrand !== undefined) {
                    sqlStringAddProduct += ' AND ';
                } else {
                    sqlStringAddProduct += ' WHERE ';
                }
                sqlStringAddProduct += `category_id IN (SELECT category_id FROM CATEGORIES WHERE slug IN (${slugCategory}))`;
            }

            if (sort !== undefined) {
                sqlStringAddProduct += ' ORDER BY ' + sort;
            }

            const result = await pool.request().query(sqlStringAddProduct);
            resolve(result.recordset);
        } catch (error) {
            reject(error);
        }
    });
};



Products.findByCategoryId = async (id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        select * FROM PRODUCTS where category_id = @id order by id desc
    `;
    await pool.request()
        .input('id', sql.Int, id)
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

Products.findByCategorySlug = async (slug, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        SELECT * FROM PRODUCTS 
        WHERE category_id IN (SELECT category_id FROM CATEGORIES WHERE slug IN (${slug}))
        order by id desc;
    `;
    await pool.request()
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                result(err);
            } else {
                result(null, data.recordset);
                sql.close();
            }
        });
};

Products.findByBrandSlug = async (slug, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        SELECT * FROM PRODUCTS 
        WHERE brand_id IN (SELECT brand_id FROM BRANDS WHERE slug IN (${slug})
        order by id desc);
    `;
    await pool.request()
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                result(err);
            } else {
                result(null, data.recordset);
                sql.close();
            }
        });
};

Products.updateById = async (id, newproduct, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
    UPDATE PRODUCTS
    SET brand_id = @brand_id,
        category_id = @category_id,
        prod_name = @prod_name,
        avatar = @avatar,
        prod_description = @prod_description,
        detailed_evaluation = @detailed_evaluation,
        manufacturer = @manufacturer,
        price = @price,
        cost = @cost,
        quantity = @quantity,
        prod_percent = @prod_percent,
        cpu = @cpu,
        hard_drive = @hard_drive,
        ram = @ram,
        mux_switch = @mux_switch,
        screen = @screen,
        webcam = @webcam,
        connection = @connection,
        prod_weight = @prod_weight,
        pin = @pin,
        operation_system = @operation_system,
        graphics = @graphics,
        on_board = @on_board
    WHERE id = @id;
    `;
    await pool.request()
        .input('id', sql.NVARCHAR(255), id)
        .input('brand_id', sql.INT, newproduct.brand_id)
        .input('category_id', sql.INT, newproduct.category_id)
        .input('prod_name', sql.NVARCHAR(255), newproduct.prod_name)
        .input('avatar', sql.VARCHAR(255), newproduct.avatar)
        .input('prod_description', sql.NVARCHAR(sql.MAX), newproduct.prod_description)
        .input('detailed_evaluation', sql.NVARCHAR(sql.MAX), newproduct.detailed_evaluation)
        .input('manufacturer', sql.NVARCHAR(255), newproduct.manufacturer)
        .input('price', sql.FLOAT, newproduct.price)
        .input('cost', sql.FLOAT, newproduct.cost)
        .input('quantity', sql.INT, newproduct.quantity)
        .input('prod_percent', sql.FLOAT, newproduct.prod_percent)
        .input('cpu', sql.NVARCHAR(255), newproduct.cpu)
        .input('hard_drive', sql.NVARCHAR(255), newproduct.hard_drive)
        .input('ram', sql.NVARCHAR(255), newproduct.ram)
        .input('mux_switch', sql.NVARCHAR(255), newproduct.mux_switch)
        .input('screen', sql.NVARCHAR(255), newproduct.screen)
        .input('webcam', sql.NVARCHAR(255), newproduct.webcam)
        .input('connection', sql.NVARCHAR(255), newproduct.connection)
        .input('prod_weight', sql.NVARCHAR(255), newproduct.prod_weight)
        .input('pin', sql.NVARCHAR(255), newproduct.pin)
        .input('operation_system', sql.NVARCHAR(255), newproduct.operation_system)
        .input('graphics', sql.NVARCHAR(255), newproduct.graphics)
        .input('on_board', sql.NVARCHAR(255), newproduct.on_board)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                console.log('update product successful')
                result(null, { "message": "success", "data": data });
                sql.close();
            }
        })
};

Products.updateByIdButNotAvatar = async (id, newproduct, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        UPDATE PRODUCTS
        SET brand_id = @brand_id,
            category_id = @category_id,
            prod_name = @prod_name,
            prod_description = @prod_description,
            manufacturer = @manufacturer,
            price = @price,
            cost = @cost,
            quantity = @quantity,
            prod_percent = @prod_percent,
            cpu = @cpu,
            hard_drive = @hard_drive,
            mux_switch = @mux_switch,
            screen = @screen,
            webcam = @webcam,
            connection = @connection,
            prod_weight = @prod_weight,
            pin = @pin,
            operation_system = @operation_system
        WHERE id = @id;
    `;
    await pool.request()
        .input('id', sql.NVARCHAR(255), id)
        .input('category_id', sql.INT, newproduct.category_id)
        .input('brand_id', sql.INT, newproduct.brand_id)
        .input('prod_name', sql.NVARCHAR(255), newproduct.prod_name)
        .input('prod_description', sql.NVARCHAR(sql.MAX), newproduct.prod_description)
        .input('manufacturer', sql.NVARCHAR(255), newproduct.manufacturer)
        .input('price', sql.FLOAT, newproduct.price)
        .input('cost', sql.FLOAT, newproduct.cost)
        .input('quantity', sql.INT, newproduct.quantity)
        .input('prod_percent', sql.FLOAT, newproduct.prod_percent)
        .input('cpu', sql.NVARCHAR(255), newproduct.cpu)
        .input('hard_drive', sql.NVARCHAR(255), newproduct.hard_drive)
        .input('mux_switch', sql.NVARCHAR(255), newproduct.mux_switch)
        .input('screen', sql.NVARCHAR(255), newproduct.screen)
        .input('webcam', sql.NVARCHAR(255), newproduct.webcam)
        .input('connection', sql.NVARCHAR(255), newproduct.connection)
        .input('prod_weight', sql.NVARCHAR(255), newproduct.prod_weight)
        .input('pin', sql.NVARCHAR(255), newproduct.pin)
        .input('operation_system', sql.NVARCHAR(255), newproduct.operation_system)
        .query(sqlStringAddProduct, (err, data) => {
            if (err) {
                console.log(err)
            } else {
                console.log('update product successful')
                result(null, { "message": "success", "data": data });
                sql.close();
            }
        })
};


Products.deleteById = async (id, result) => {
    const pool = await connect;
    const sqlStringAddProduct = `
        DELETE FROM REVIEWS
        WHERE product_id = @id;
        DELETE FROM ORDER_DETAILS
        WHERE product_id = @id
        DELETE FROM CARTS
        WHERE product_id = @id;
        DELETE FROM IMAGES
        WHERE product_id = @id;
        DELETE FROM PRODUCTS
        WHERE id = @id
    `;
    await pool.request()
        .input('id', sql.Int, id)
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

Products.getAllWithPaginationAndFilter = async (reqData, resultCallback) => {
    try {
        const pool = await connect;

        let page = reqData.page;
        let limit = reqData.limit;
        let sort = reqData.sort;
        let brand = reqData.brand;
        let category = reqData.category;

        if (brand.includes(',')) {
            brand = brand.split(',').join(',').replace(/,/g, "','")
        }

        if (category.includes(',')) {
            category = category.split(',').join(',').replace(/,/g, "','")
        }

        const countQuery = `SELECT COUNT(*) AS totalCount FROM Products`;
        const countResult = await pool.request().query(countQuery);
        const totalCount = countResult.recordset[0].totalCount;
        const totalPages = Math.ceil(totalCount / limit);

        const offset = ((page > totalPages ? 1 : page) - 1) * limit;

        let totalProductFilter = []

        let query = `SELECT * FROM PRODUCTS`;

        if (!brand && !category) {
            query += ` WHERE 1=1`;
        } else if (brand && category) {
            query += ` WHERE brand_id IN (SELECT brand_id FROM BRANDS WHERE slug IN ('${brand}')) 
            AND category_id IN (SELECT category_id FROM CATEGORIES WHERE slug IN ('${category}'))`
            totalProductFilter = await pool.request().query(query);
        } else if (brand && !category) {
            query += ` WHERE brand_id IN (SELECT brand_id FROM BRANDS WHERE slug IN ('${brand}'))`;
            totalProductFilter = await pool.request().query(query);
        } else if (!brand && category) {
            query += ` WHERE category_id IN (SELECT category_id FROM CATEGORIES WHERE slug IN ('${category}'))`;
            totalProductFilter = await pool.request().query(query);
        }

        if (sort === 'gia-thap-den-cao' || sort === 'gia-cao-den-thap') {
            const tableSortConvert = {
                "gia-thap-den-cao": "asc",
                "gia-cao-den-thap": "desc"
            }

            sort = tableSortConvert[sort]

            query += ` ORDER BY price ${sort.toUpperCase()}`;
        } else {
            query += ` ORDER BY id * -1`;
        }

        query += ` OFFSET ${offset} ROWS FETCH NEXT ${limit} ROWS ONLY`;

        const result = await pool.request().query(query);
        console.log(totalProductFilter);
        const data = {
            products: result.recordset,
            currentPage: parseInt(page),
            totalPages:
                (brand || category)
                    ? Math.ceil(totalProductFilter.recordset.length / parseInt(limit))
                    : totalPages,
            totalProducts: (brand || category) ? totalProductFilter.recordset.length : totalCount,
            limit: parseInt(limit),
        };

        resultCallback(null, data);
    } catch (error) {
        console.error('Error:', error.message);
        resultCallback(error, null);
    } finally {
        try {
            await sql.close();
        } catch (err) {
            console.error('Error closing connection:', err.message);
        }
    }
};

Products.searchProductsWithPagination = async (reqData, resultCallback) => {
    try {
        let { searchKeyword, pageNumber, limit, sort } = reqData;

        const pool = await connect;

        let sqlQuery = `
            SELECT COUNT(*) as totalRecords
            FROM PRODUCTS
            WHERE [prod_name] LIKE '%'+ @searchKeyword + '%'
            OR [prod_description] LIKE '%'+ @searchKeyword + '%'
            OR [manufacturer] LIKE '%'+ @searchKeyword + '%'
            OR [cpu] LIKE '%'+ @searchKeyword + '%'
            OR [hard_drive] LIKE '%'+ @searchKeyword + '%'
            OR [mux_switch] LIKE '%'+ @searchKeyword + '%'
            OR [screen] LIKE '%'+ @searchKeyword + '%'
            OR [webcam] LIKE '%'+ @searchKeyword + '%'
            OR [connection] LIKE '%'+ @searchKeyword + '%'
            OR [ram] LIKE '%'+ @searchKeyword + '%'
            OR [graphics] LIKE '%'+ @searchKeyword + '%'
            OR [on_board] LIKE '%'+ @searchKeyword + '%'
            OR [detailed_evaluation] LIKE '%'+ @searchKeyword + '%'
        `;

        const resultCount = await pool.request()
            .input('SearchKeyword', sql.NVARCHAR(255), searchKeyword)
            .query(sqlQuery);
        const totalRecords = resultCount.recordset[0].totalRecords;

        const totalPages = Math.ceil(totalRecords / limit);

        sqlQuery = `
            SELECT *
            FROM PRODUCTS
            WHERE [prod_name] LIKE '%' + @searchKeyword + '%'
                OR [prod_description] LIKE '%' + @searchKeyword + '%'
                OR [manufacturer] LIKE '%' + @searchKeyword + '%'
                OR [cpu] LIKE '%' + @searchKeyword + '%'
                OR [hard_drive] LIKE '%' + @searchKeyword + '%'
                OR [mux_switch] LIKE '%' + @searchKeyword + '%'
                OR [screen] LIKE '%' + @searchKeyword + '%'
                OR [webcam] LIKE '%' + @searchKeyword + '%'
                OR [connection] LIKE '%' + @searchKeyword + '%'
                OR [ram] LIKE '%' + @searchKeyword + '%'
                OR [graphics] LIKE '%' + @searchKeyword + '%'
                OR [on_board] LIKE '%' + @searchKeyword + '%'
                OR [detailed_evaluation] LIKE '%' + @searchKeyword + '%'
            ORDER BY
                CASE
                    WHEN @sort = '' THEN [id] * -1 -- Sắp xếp theo id tăng dần
                    WHEN @sort = 'asc' THEN [price] -- Sắp xếp theo giá tăng dần
                    WHEN @sort = 'desc' THEN [price] * -1 -- Sắp xếp theo giá giảm dần
                END
            OFFSET (@pageNumber - 1) * @limit ROWS
            FETCH NEXT @limit ROWS ONLY;
        `;

        const result = await pool.request()
            .input('SearchKeyword', sql.NVARCHAR(255), searchKeyword)
            .input('PageNumber', sql.INT, pageNumber)
            .input('Limit', sql.INT, limit)
            .input('Sort', sql.NVARCHAR(10), sort)
            .query(sqlQuery);

        const response = {
            totalRecords,
            totalPages,
            currentPage: pageNumber,
            limit: limit,
            data: result.recordset,
        };

        resultCallback(null, response);
    } catch (error) {
        console.error('SQL error:', error.message);
        resultCallback(error.message, null);
    }
};


module.exports = Products;

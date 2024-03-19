const { sql, connect } = require('../../connect');
const bcrypt = require('bcrypt');
const USERS = require('../../models/user');
const PROVIDED_USERS = require('../../models/provided_users');
const jwt = require('jsonwebtoken')
var passport = require('passport');
var LocalStrategy = require('passport-local');
var FacebookStrategy = require('passport-facebook');
var GoogleStrategy = require('passport-google-oidc');
const mailer = require('../../utils/mailer.js');
const CART = require('../../models/cart.js');
const cors = require('cors');
require('dotenv').config()

function controllerLogin(req, res) {
    res.render('login2')
}

async function selectAllUsers(req, res) {
    try {
        const pool = await connect;
        var sqlString = 'SELECT * FROM USERS';
        return await pool.request().query(sqlString, (err, data) => {
            res.send({ search: data.recordset });
        })
    } catch (error) {
        console.log('lỗi ở method GET /users', error);
    }
}


async function register(req, res) {
    try {
        const name = req.body.name
        const email = req.body.email
        const GID = req.body.GID
        const pass = req.body.pass
        const pool = await connect;
        let emailAlreadyExists = false;
        const hashedPass = await bcrypt.hash(pass, 10);
        const registrationToken = await bcrypt.hash(email, 10);
        console.log(name, email, pass)

        let sqlStringSelectUsers = 'SELECT * FROM USERS';
        await pool.request().query(sqlStringSelectUsers, async (err, data) => {
            // console.log(data.recordset)
            let dataUsers = data.recordset;

            for (let i = 0; i < dataUsers.length; i++) {
                // console.log(dataUsers[i].email, email)
                if (dataUsers[i].email == email) {
                    emailAlreadyExists = true;
                    break;
                }
            }

            if (emailAlreadyExists == true) {
                res.send({ emailAlreadyExists: emailAlreadyExists })
            } else {
                const sqlStringAddSearch = `
            insert into USERS(name,password,email,role,registration_token, confirmation_status) 
            values(@name,@password,@email,'user',@registrationToken, 0)
            `;
                await pool.request()
                    .input('name', sql.NVARCHAR(100), name)
                    .input('password', sql.VARCHAR(255), hashedPass)
                    .input('email', sql.VARCHAR(100), email)
                    .input('registrationToken', sql.VARCHAR(255), registrationToken)
                    .query(sqlStringAddSearch, (err, data) => {
                        if (err) console.log(err)

                        mailer.sendMail(
                            email,
                            "Xác nhận đăng ký tài khoản website bán laptop",
                            `
                            <p>Nhấn vào link bên dưới để xác nhận đăng ký tài khoản</p>
                            <a href="http://localhost:8000/confirm/${email}?registrationToken=${registrationToken}&GID=${GID}">Xác nhận đăng ký</a>
                            `
                        );

                        res.json({ message: "Vui lòng vào mail của bạn để xác nhận tài khoản!" })


                    })
            }
        })

    } catch (error) {
        console.log('lỗi ở method GET /search', error);
    }
}

async function confirmRegister(req, res) {
    const email = req.params.email;
    let GID
    if (req.query.GID) {
        GID = req.query.GID
    }
    const pool = await connect;
    const registrationToken = req.query.registrationToken;
    // console.log(email, registrationToken)

    USERS.findByEmail(email, (err, data) => {
        if (err) { res.send(err) }
        let dataUser = data;
        if (!dataUser) {
            res.json({ message: "Email not found!" })
            return
        }
        bcrypt.compare(email, registrationToken, async (err, result) => {
            if (err) console.log(err)
            else {
                const sqlStringAddSearch = `
                UPDATE USERS
                SET confirmation_status = 1
                WHERE email = @email;
            `;
                await pool.request()
                    .input('email', sql.VARCHAR(100), email)
                    .query(sqlStringAddSearch, (err, data) => {
                        if (err) console.log(err)
                        else {
                            // res.json({ message: "Bạn đã tạo tài khoản thành công" })
                            if (GID) {
                                CART.findByGID(GID, (err, cart) => {
                                    if (err) console.log(err);
                                    if (cart.length !== 0) {
                                        // console.log(cart);
                                        CART.updateCartByNewAccount(GID, email, (err, data) => {
                                            if (err) {
                                                console.log(err);
                                                res.json({ success: false, err: err })
                                            }
                                            else {
                                                for (let i = 0; i < cart.length; i++) {
                                                    const currentCart = cart[i];
                                                    // Lưu cart mới vào cơ sở dữ liệu
                                                    CART.create(currentCart, (err, data) => {
                                                        if (err) {
                                                            console.log(err);
                                                            return res.json({ success: false, err: err });
                                                        } else {
                                                            console.log("line 141 controllerLogin3 - Cart created successfully:");
                                                        }
                                                    });
                                                }
                                                return res.redirect('http://localhost:3000/Phoenix-technology#/auth?success=true');
                                            }
                                        })
                                    } else {
                                        return res.redirect('http://localhost:3000/Phoenix-technology#/auth?success=true')
                                    }
                                })
                            }

                        }
                    })
                // Update user's verification status in the database
                // Redirect to a success page or show a success message
                // alert("Đăng ký tài khoản thành công!")

            }
        })

    })

}

async function confirmRegisterPost(req, res) {
    const email = req.params.email;
    const pool = await connect;
    const registrationToken = await bcrypt.hash(email, 10);
    // console.log(email, registrationToken)

    USERS.findByEmail(email, (err, data) => {
        if (err) { res.send(err) }
        let dataUser = data[0];
        if (!dataUser) { res.json({ status: false, message: "Email not found!" }) }
        mailer.sendMail(
            email,
            "Xác nhận đăng ký tài khoản website bán laptop",
            `
    <p>Nhấn vào link bên dưới để xác nhận đăng ký tài khoản</p>
    <a href="http://localhost:8000/confirm/${email}?registrationToken=${registrationToken}">Xác nhận đăng ký</a>
    `
        );
        res.json({ status: true, message: "Vui lòng vào mail của bạn để xác nhận tài khoản!" })

    })

}

passport.use(new LocalStrategy({
    usernameField: 'email', // Định nghĩa trường chứa giá trị username trong req.body
    passwordField: 'pass', // Định nghĩa trường chứa giá trị password trong req.body
},
    function verify(email, pass, cb) {
        USERS.findByEmail(email, async (err, data) => {
            let dataUser = data;
            if (err) { return cb(err); }
            if (!dataUser) {
                return cb(null, false, { message: 'Incorrect email or password.' });
            }
            bcrypt.compare(pass, dataUser.password, (err, data) => {
                if (err) { return cb(err); }
                if (!data) {
                    return cb(null, false, { message: 'Incorrect email or password.' });
                }
                if (dataUser.confirmation_status == 1) {
                    return cb(null, dataUser);
                }
                else {
                    return cb(null, false, { message: 'Tài khoản chưa được xác thực.' });
                }
            })

        })
        // console.log(email, pass)
    }));
function login(req, res) {
    // const { username, password } = req.body;
    passport.authenticate('local', (err, dataUser, errMessage) => {
        if (err) return res.status(500).json('loi server');
        if (!dataUser) res.json({ errMessage: errMessage.message });
        console.log(dataUser)
        let roleUser = dataUser.role;
        login = (roleUser, redirectUrl) => {
            let token = jwt.sign({
                id: dataUser.id,
                role: roleUser
            }, 'secretId')
            return res.json({
                success: true,
                message: 'Đăng nhập thành công!',
                token: token,
                user_name: dataUser.name,
                role: dataUser.role,
                redirectUrl: redirectUrl
            })
        }
        // console.log(roleUser)
        if (roleUser === 'admin') {
            let redirectUrl = '/Phoenix-technology#/management'
            login(roleUser, redirectUrl);
        } else if (roleUser === 'user') {
            let redirectUrl = '/Phoenix-technology#/'
            login(roleUser, redirectUrl);
        }
    })(req, res);
}

passport.use(new FacebookStrategy({
    clientID: process.env.FACEBOOK_CLIENT_ID,
    clientSecret: process.env.FACEBOOK_CLIENT_SECRET,
    callbackURL: "/auth/facebook/callback",
    state: true
}, async function verify(accessToken, refreshToken, profile, cb) {
    const pool = await connect;
    console.log(profile)
    PROVIDED_USERS.findByIdProvider(profile.id, 'https://www.facebook.com', async (err, user) => {
        console.log(user.length)
        if (err) { return cb(err); }
        if (user.length === 0) {
            console.log('hi')
            const sqlStringAddSearch = `
            insert into USERS(name,provider,role,subject) 
            values(@name,@provider,'user',@subject)
            `;
            await pool.request()
                .input('name', sql.NVARCHAR(100), profile.displayName)
                .input('provider', sql.VARCHAR(255), 'https://www.facebook.com')
                .input('subject', sql.VARCHAR(255), profile.id)
                .query(sqlStringAddSearch, (err, data) => {
                    if (err) { console.log(err); return cb(err); }
                    USERS.findLast((err, user) => {
                        if (err) { console.log(err); return cb(err); }
                        let user_id = user.id
                        console.log(user_id)
                        const provided_user = new PROVIDED_USERS({
                            user_id: user_id,
                            name: profile.displayName,
                            // email: profile.email,
                            provider: 'https://www.facebook.com',
                            subject: profile.id
                        });
                        PROVIDED_USERS.create(provided_user, (err, data) => {
                            if (err) { console.log(err); return cb(err); }
                            // console.log(provided_user)
                            let user = {
                                user_id: user_id,
                                name: profile.displayName
                            };
                            return cb(null, user);
                        })
                    })
                })
        } else {
            const sqlStringAddSearch = `
            SELECT u.* 
            FROM USERS u 
            JOIN PROVIDED_USERS p ON u.subject = p.subject 
            WHERE p.subject = @subject;
            `;
            await pool.request()
                .input('subject', sql.VARCHAR(255), profile.id)
                .query(sqlStringAddSearch, (err, data) => {
                    console.log('line306 controllerLogin3: ', data);
                    return cb(null, data.recordset[0]);
                })
        }
    })
}));
function loginFb_Get(req, res) {
    passport.authenticate('facebook')(req, res);
}


function loginFb_Get_Callback(req, res) {


    passport.authenticate('facebook', { failureRedirect: 'http://localhost:3000/#/auth' },
        function (err, user) {
            console.log('line 331 controllerlogin3: ', user);
            if (err) return res.status(500).json('loi server');
            if (!user) { return res.redirect('http://localhost:3000/#/auth'); }
            let token = jwt.sign({
                id: user.user_id || user.id,
                role: "user"
            }, 'secretId')
            // res.cookie('token', token, { httpOnly: false });
            return res.redirect(`http://localhost:3000/#/?username=${user.name}&token=${token}`);


            // res.send(user)

        })(req, res)
}

function loginFb(req, res) {
    res.setHeader("Access-Control-Allow-Origin", "*")
    res.setHeader("Access-Control-Allow-Credentials", "true");
    res.setHeader("Access-Control-Max-Age", "1800");
    res.setHeader("Access-Control-Allow-Headers", "content-type");
    res.setHeader("Access-Control-Allow-Methods", "PUT, POST, GET, DELETE, PATCH, OPTIONS");
    // const { username, password } = req.body;
    passport.authenticate('facebook', (err, dataUser) => {
        if (err) return res.json({ success: false, msg: err });
        // if (!dataUser) return res.json('username or password invalid');
        console.log(dataUser)
        // let roleUser = dataUser.role;
        // login = (roleUser, redirectUrl) => {
        //     let token = jwt.sign({
        //         id: dataUser.id,
        //         role: roleUser
        //     }, 'secretId')
        //     return res.json({
        //         success: true,
        //         message: 'Đăng nhập thành công!',
        //         token: token,
        //         redirectUrl: redirectUrl
        //     })
        // }
        // // console.log(roleUser)
        // if (roleUser === 'admin') {
        //     let redirectUrl = '/management'
        //     login(roleUser, redirectUrl);
        // } else if (roleUser === 'user') {
        //     let redirectUrl = '/'
        //     login(roleUser, redirectUrl);
        // }
    })(req, res);
}

passport.use(new GoogleStrategy({
    clientID: process.env['GOOGLE_CLIENT_ID'],
    clientSecret: process.env['GOOGLE_CLIENT_SECRET'],
    callbackURL: '/oauth2/redirect/google',
    scope: ['profile']
}, async function verify(issuer, profile, cb) {
    const pool = await connect;
    console.log(profile)
    PROVIDED_USERS.findByIdProvider(profile.id, 'https://www.google.com', async (err, user) => {
        console.log(user.length)
        if (err) { return cb(err); }
        if (user.length === 0) {
            console.log('hi')
            const sqlStringAddSearch = `
            insert into USERS(name,provider,role,subject) 
            values(@name,@provider,'user',@subject)
            `;
            await pool.request()
                .input('name', sql.NVARCHAR(100), profile.displayName)
                .input('provider', sql.VARCHAR(255), 'https://www.google.com')
                .input('subject', sql.VARCHAR(255), profile.id)
                .query(sqlStringAddSearch, (err, data) => {
                    if (err) { console.log(err); return cb(err); }
                    USERS.findLast((err, user) => {
                        if (err) { console.log(err); return cb(err); }
                        let user_id = user.id
                        console.log(user_id)
                        const provided_user = new PROVIDED_USERS({
                            user_id: user_id,
                            name: profile.displayName,
                            // email: profile.email,
                            provider: 'https://www.google.com',
                            subject: profile.id
                        });
                        PROVIDED_USERS.create(provided_user, (err, data) => {
                            if (err) { console.log(err); return cb(err); }
                            // console.log(provided_user)
                            let user = {
                                user_id: user_id,
                                name: profile.displayName
                            };
                            return cb(null, user);
                        })
                    })
                })
        } else {
            const sqlStringFindUser = `
            SELECT u.* 
            FROM USERS u 
            JOIN PROVIDED_USERS p ON u.subject = p.subject 
            WHERE p.subject = @subject;
            `;
            await pool.request()
                .input('subject', sql.VARCHAR(255), profile.id)
                .query(sqlStringFindUser, (err, data) => {
                    console.log('line306 controllerLogin3: ', data);
                    return cb(null, data.recordset[0]);
                })
        }
    })
}));

function loginGG_Get(req, res) {
    passport.authenticate('google')(req, res);
}

function loginGG_Get_Callback(req, res) {

    passport.authenticate('google', { failureRedirect: 'http://localhost:3000/#/auth' },
        function (err, user) {
            console.log('line 331 controllerlogin3: ', user);
            if (err) return res.status(500).json('loi server');
            if (!user) { return res.redirect('http://localhost:3000/#/auth'); }
            let token = jwt.sign({
                id: user.user_id || user.id,
                role: "user"
            }, 'secretId')
            // res.cookie('token', token, { httpOnly: false });
            return res.redirect(`http://localhost:3000/#/?username=${user.name}&token=${token}`);


            // res.send(user)

        })(req, res)
}

function logout(req, res) {
    // Đầu tiên, bạn cần đảm bảo rằng tên của cookie token là chính xác
    const tokenCookieName = 'token'; // Đổi tên này thành tên bạn đã sử dụng cho cookie token

    // Tạo một cookie mới với giá trị trống và thời gian hết hạn trong quá khứ để xóa cookie cũ
    res.cookie(tokenCookieName, '', { expires: new Date(0) });

    // Gửi phản hồi về client
    return res.json({
        success: true,
        message: 'Đã đăng xuất thành công. Cookie token đã được xóa.',
    });
}




module.exports = {
    controllerLogin, selectAllUsers, register, confirmRegister, login, loginFb, logout, loginFb_Get, loginFb_Get_Callback,
    confirmRegisterPost, loginGG_Get, loginGG_Get_Callback
}
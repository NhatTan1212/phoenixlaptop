import { EditUser } from '../../../callAPI/api';
import React, { useState, useEffect, useContext } from 'react';
import { EyeInvisibleOutlined, EyeTwoTone } from '@ant-design/icons';
import {
    Input, Select, Row, Col, Spin
} from 'antd';
import './EditUserDetails.scss'
import Cookies from 'js-cookie';
import Context from '../../../store/Context';


const EditUserDetails = ({ setIsActioning, setActioningUser, actioningUser }) => {
    let token = Cookies.get('token')
    const context = useContext(Context)

    const [name, setName] = useState(actioningUser.name)

    const [password, setPassword] = useState('')
    const [hasPasswordChanged, setHasPasswordChanged] = useState(false);
    const [passwordInValid, setPasswordInvalid] = useState(false);

    const [rePassword, setRePassword] = useState('')
    const [hasRePasswordChanged, setHasRePasswordChanged] = useState(false);
    const [rePasswordInValid, setRePasswordInvalid] = useState(false);

    const [role, setRole] = useState(actioningUser.role)

    const [loading, setLoading] = useState(false)

    const onChangePassword = (e) => {
        const newPassword = e.target.value;
        setHasPasswordChanged(true);
        setPassword(newPassword);
        if (newPassword !== '') {
            const regexPassword = /^.{6,}$/;
            const isPasswordValid = regexPassword.test(newPassword);
            setPasswordInvalid(!isPasswordValid);
        } else {
            setPasswordInvalid(false);
        }
    };

    const onChangeRePassword = (e) => {
        const newPassword = e.target.value;
        setHasRePasswordChanged(true);
        setRePassword(newPassword);
        if (newPassword !== '') {
            const regexPassword = /^.{6,}$/;
            const isPasswordValid = regexPassword.test(newPassword);
            setRePasswordInvalid(!isPasswordValid);
        } else {
            setRePasswordInvalid(false);
        }
    };

    const onFinish = (values) => {
        values.preventDefault();

        setLoading(true)

        let hasError = false;
        if (passwordInValid) {
            setPasswordInvalid(true);
            hasError = true;
        }
        if (rePasswordInValid) {
            setRePasswordInvalid(true);
            hasError = true;
        }
        if (hasError || (password !== rePassword)) {
            context.Message("warning", "Vui lòng kiểm tra lại thông tin.");
            setLoading(false)
            return;
        }

        const formData = {
            token: token,
            id: actioningUser.id,
            name: name,
            password: password,
            role: role
        }

        setTimeout(() => {
            EditUser(formData).then(response => {
                console.log(response);
                if (response.success) {
                    setIsActioning(false);
                    context.Message("success", "Cập nhật tài khoản thành công.")
                }
            })
        }, Math.floor(Math.random() * (1000 - 500 + 1)) + 500);
    };

    return (
        <Spin spinning={loading} size='large'>
            <div className='wrap-modal-fpm w-full'>
                {actioningUser &&
                    <div>
                        <form
                            onSubmit={onFinish}
                            method="post"
                            encType="multipart/form-data"
                            className='text-end'
                        >
                            <Input type="hidden" name="id"
                                value={actioningUser.id} />
                            <Row className='mt-[15px]'>
                                <Col span={24}
                                    className='text-start px-[15px] pl-0'>
                                    <h3><span className='text-red-500'>* </span>Tên tài khoản:</h3>
                                    <Input
                                        className='mb-2 mt-0'
                                        name='name'

                                        onChange={(e) => {
                                            setName(e.target.value)
                                        }}
                                        value={name || actioningUser.name}
                                    />

                                    <h3><span className='text-red-500'>* </span>Mật khẩu:</h3>
                                    <Input.Password
                                        className='mb-2 mt-0 input-password-edituserdetails'
                                        iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
                                        value={password}
                                        onChange={(e) => { onChangePassword(e) }}
                                    />

                                    <div className='wrap-err-mess'>
                                        {(hasPasswordChanged && passwordInValid)
                                            ? <p className='err-mess'>Mật khẩu phải có ít nhất 6 ký tự</p> : password.length > 255
                                                ? <p className='err-mess'>Mật khẩu không được vượt quá 255 ký tự</p> : null
                                        }
                                    </div>

                                    <h3><span className='text-red-500'>* </span>Nhập lại mật khẩu:</h3>
                                    <Input.Password
                                        className='mb-2 mt-0 input-password-edituserdetails'
                                        iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
                                        value={rePassword}
                                        onChange={(e) => { onChangeRePassword(e) }}
                                    />

                                    <div className='wrap-err-mess'>
                                        {(hasRePasswordChanged && rePasswordInValid)
                                            ? <p className='err-mess'>Mật khẩu phải có ít nhất 6 ký tự</p> : rePassword.length > 255
                                                ? <p className='err-mess'>Mật khẩu không được vượt quá 255 ký tự</p> : (rePassword !== password && hasRePasswordChanged)
                                                    ? <p className='err-mess'>Mật khẩu không trùng khớp</p> :
                                                    null
                                        }
                                    </div>

                                    <h3><span className='text-red-500'>* </span>Vai trò:</h3>
                                    <Select
                                        className='mb-2 mt-0'
                                        name='role'
                                        value={role || actioningUser.role}
                                        onChange={(e) => {
                                            setRole(e)
                                        }}
                                        style={{
                                            width: '100%',
                                        }}

                                        options={[
                                            { value: 'admin', label: 'admin' },
                                            { value: 'user', label: 'user' }
                                        ]}
                                    />
                                </Col>

                            </Row>

                            <div className='inline-block mt-5'>
                                <Input type='submit' defaultValue={"Lưu thay đổi"}
                                    className='bg-[#c8191f] text-white'>
                                </Input>
                            </div>
                        </form>
                    </div>
                }
            </div>
        </Spin>
    )
}

export default EditUserDetails
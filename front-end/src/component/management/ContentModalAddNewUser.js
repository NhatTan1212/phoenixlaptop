import { AddNewUser } from '../../callAPI/api';
import React, { useState, useContext } from 'react';
import {
    Input, Select, Row, Col
} from 'antd';
import '../../component/management/modalFPM.scss'
import Cookies from 'js-cookie';
import Context from '../../store/Context';
import { EyeInvisibleOutlined, EyeTwoTone } from '@ant-design/icons';


const ContentModalAddNewUser = ({ isActioning, setIsActioning }) => {
    let token = Cookies.get('token');
    const context = useContext(Context);
    const [name, setName] = useState('');
    const [password, setPassword] = useState('');
    const [email, setEmail] = useState('');
    const [role, setRole] = useState('');

    const onFinish = (values) => {

        values.preventDefault();
        const formData = {
            token: token,
            name: name,
            password: password,
            email: email,
            role: role
        }


        AddNewUser(formData).then(response => {
            console.log(response);
            if (response.success) {
                setIsActioning(false);
                context.Message("success", "Thêm tài khoản thành công.")

            }
        })
    };

    return (
        <div className='wrap-modal-fpm w-full'>
            <div>
                <form
                    onSubmit={onFinish}
                    method="post"
                    encType="multipart/form-data"
                    className='text-end'
                >

                    <Row className='mt-[15px]'>
                        <Col span={12}
                            className='text-start px-[15px] pl-0'>
                            <h3><span className='text-red-500'>* </span>Tên tài khoản:</h3>
                            <Input
                                className='mb-2 mt-0'
                                name='name'

                                onChange={(e) => {
                                    setName(e.target.value)
                                }}
                                value={name}
                            />
                            <h3><span className='text-red-500'>* </span>Password:</h3>
                            <Input.Password
                                className='mb-2 mt-0 input-password-edituserdetails'
                                iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
                                name='password'
                                value={password}
                                onChange={(e) => {
                                    setPassword(e.target.value)
                                }}
                            />
                            {/* <Input
                                className='mb-2 mt-0'
                                name='password'
                                value={password}
                                onChange={(e) => {
                                    setPassword(e.target.value)
                                }}>
                            </Input> */}
                        </Col>
                        <Col span={12} className='text-start px-[15px] pr-0'>

                            <h3><span className='text-red-500'>* </span>Email:</h3>
                            <Input
                                className='mb-2 mt-0'
                                name='email'
                                value={email}
                                onChange={(e) => {
                                    setEmail(e.target.value)
                                }}></Input>


                            <h3><span className='text-red-500'>* </span>Vai trò:</h3>
                            <Select
                                className='mb-2 mt-0'
                                name='role'
                                value={role}
                                onChange={(e) => {
                                    setRole(e)
                                }}
                                style={{
                                    width: '100%',
                                }}

                                options={
                                    [{
                                        value: 'admin',
                                        label: 'admin'
                                    },
                                    {
                                        value: 'user',
                                        label: 'user'
                                    }]

                                }
                            />
                        </Col>

                    </Row>

                    <div className='inline-block mt-5'>
                        <Input type='submit' defaultValue={"Thêm tài khoản"}
                            className='bg-[#c8191f] text-white'>
                        </Input>
                    </div>
                </form>
            </div>
        </div>
    )
}

export default ContentModalAddNewUser
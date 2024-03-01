import React, { useState, useEffect, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ChangeUserPasswordById, GetUsersById } from '../../../callAPI/api';
import jwtDecode from 'jwt-decode';
import Cookies from 'js-cookie';
import Context from '../../../store/Context';
import { Button, Form, Input, Menu } from 'antd';
import { UserOutlined, KeyOutlined } from '@ant-design/icons';
import '../profile/profileManager.scss'
import EditUserInfo from '../../../component/management/user/EditUserInfo';

const ProfileManager = () => {
    const context = useContext(Context);
    const navigate = useNavigate();
    const token = Cookies.get('token');
    const { id } = useParams();
    const [userData, setUserData] = useState(null);
    const [userId, setUserId] = useState('');
    const [isCurrentUser, setIsCurrentUser] = useState(false);
    const [currentMenu, setCurrentMenu] = useState('info');
    const [editModalVisible, setEditModalVisible] = useState(false);
    const [formValues, setFormValues] = useState({
        oldPassword: '',
        newPassword: '',
        confirmNewPassword: '',
    });
    const [formKey, setFormKey] = useState(0);

    useEffect(() => {
        const decodedToken = jwtDecode(token);
        if (decodedToken && decodedToken.id) {
            setUserId(decodedToken.id);
        }
    }, [token]);

    useEffect(() => {
        if (!userId) return;

        const fetchUserData = async () => {
            if (parseInt(id, 10) === userId) {
                setIsCurrentUser(true);
                const response = await GetUsersById(id);
                setUserData(response);
            } else {
                setIsCurrentUser(false);
                navigate(`/profile/${userId}`)
                context.Message('warning', 'Bạn không thể truy cập vào Prolfile trên!')
            }
        };

        fetchUserData();
    }, [id, userId, navigate]);

    const handleClick = (e) => {
        setCurrentMenu(e.key);
    };

    const handleEdit = () => {
        setEditModalVisible(true);
    };

    const handleSaveUserInfo = (values) => {
        setUserData(values);

        return new Promise((resolve) => {
            setTimeout(() => {
                resolve();
            }, 1000);
        });
    };
    const handleCancelEdit = () => {
        setEditModalVisible(false);
    };

    const onFinishChangePassword = (values) => {
        if (values.oldPassword && values.newPassword && values.confirmNewPassword) {
            console.log('Received values:', values)

            const newUserInfo = {
                id: id,
                oldPassword: values.oldPassword,
                newPassword: values.newPassword
            }

            ChangeUserPasswordById(newUserInfo).then((data) => {
                if (data.success) {
                    context.Message("success", data.message)
                    setFormValues({
                        oldPassword: '',
                        newPassword: '',
                        confirmNewPassword: '',
                    });
                    setFormKey((prevKey) => prevKey + 1);
                } else {
                    context.Message("error", data.message)
                }
            })
        }
    };

    const handleInputChange = (fieldName, value) => {
        setFormValues({
            ...formValues,
            [fieldName]: value,
        });
    };

    return (
        <div className="flex justify-center h-[600px] bg-gray-100">
            <div className="w-[1060px] h-auto bg-white p-8 rounded-lg shadow-md m-5">
                <div className="flex">
                    <div className="w-[25%]">
                        <Menu
                            onClick={handleClick}
                            selectedKeys={[currentMenu]}
                            mode="inline"
                        >
                            <Menu.Item key="info" icon={<UserOutlined />}>
                                Thông tin cá nhân
                            </Menu.Item>
                            <Menu.Item key="password" icon={<KeyOutlined />}>
                                Thay đổi mật khẩu
                            </Menu.Item>
                        </Menu>
                    </div>
                    <div className="w-[60%] m-auto">
                        {currentMenu === 'info' && isCurrentUser && userData && (
                            <div className="space-y-4">
                                <p className="text-lg font-semibold mb-8 mt-3">Thông tin người dùng</p>
                                <div className="grid grid-cols-8 gap-4">
                                    <p className="col-span-3 text-gray-600">User ID:</p>
                                    <p className="col-span-5 text-gray-800 font-semibold">{userData.id}</p>
                                    <p className="col-span-3 text-gray-600">Tên người dùng:</p>
                                    <p className="col-span-5 text-gray-800 font-semibold">{userData.name}</p>
                                    <p className="col-span-3 text-gray-600">Email:</p>
                                    <p className="col-span-5 text-gray-800 font-semibold">{userData.email}</p>
                                    <p className="col-span-3 text-gray-600">Số điện thoại:</p>
                                    <p className="col-span-5 text-gray-800 font-semibold">{userData.phone}</p>
                                </div>
                                <div className="flex justify-end">
                                    <Button
                                        onClick={handleEdit}
                                        type="primary">
                                        Chỉnh sửa thông tin
                                    </Button>
                                </div>
                            </div>
                        )}
                        {currentMenu === 'password' && (
                            <div className="space-y-4">
                                <p className="text-lg font-semibold mb-8 mt-3">Thay đổi mật khẩu</p>
                                <Form
                                    key={formKey}
                                    layout="vertical"
                                    onFinish={onFinishChangePassword}
                                >
                                    <Form.Item
                                        name="oldPassword"
                                        label="Mật khẩu cũ"
                                        rules={[{ required: true, message: 'Vui lòng nhập mật khẩu cũ' }]}
                                    >
                                        <Input.Password
                                            className="w-full user-info-input"
                                            value={formValues.oldPassword}
                                            onChange={(e) => handleInputChange('oldPassword', e.target.value)}
                                            placeholder="Nhập mật khẩu cũ"
                                        />
                                    </Form.Item>
                                    <Form.Item
                                        name="newPassword"
                                        label="Mật khẩu mới"
                                        rules={[
                                            { required: true, message: 'Vui lòng nhập mật khẩu mới' },
                                            { min: 6, message: 'Mật khẩu phải có ít nhất 6 ký tự' },
                                        ]}
                                    >
                                        <Input.Password
                                            className="w-full user-info-input"
                                            value={formValues.newPassword}
                                            onChange={(e) => handleInputChange('newPassword', e.target.value)}
                                            placeholder="Nhập mật khẩu mới"
                                        />
                                    </Form.Item>
                                    <Form.Item
                                        name="confirmNewPassword"
                                        label="Xác nhận mật khẩu mới"
                                        dependencies={['newPassword']}
                                        rules={[
                                            { required: true, message: 'Vui lòng xác nhận mật khẩu mới' },
                                            ({ getFieldValue }) => ({
                                                validator(_, value) {
                                                    if (!value || getFieldValue('newPassword') === value) {
                                                        return Promise.resolve();
                                                    }
                                                    return Promise.reject(new Error('Mật khẩu xác nhận không khớp'));
                                                },
                                            }),
                                        ]}
                                    >
                                        <Input.Password
                                            className="w-full user-info-input"
                                            value={formValues.confirmNewPassword}
                                            onChange={(e) => handleInputChange('confirmNewPassword', e.target.value)}
                                            placeholder="Xác nhận mật khẩu mới"
                                        />
                                    </Form.Item>
                                    <Form.Item className="flex justify-end">
                                        <Button>Hủy</Button>
                                        <Button className="ml-2" type="primary" htmlType="submit">
                                            Xác nhận
                                        </Button>
                                    </Form.Item>

                                </Form>
                            </div>
                        )}
                    </div>
                </div>
            </div>
            {editModalVisible ?
                <EditUserInfo
                    visible={editModalVisible}
                    onCancel={handleCancelEdit}
                    onSave={handleSaveUserInfo}
                    userData={userData}
                /> : null
            }

        </div>
    );
};

export default ProfileManager;

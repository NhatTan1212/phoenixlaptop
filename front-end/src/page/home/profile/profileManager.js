import React, { useState, useEffect, useContext } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faLocationDot, faPlus } from '@fortawesome/free-solid-svg-icons';
import { useParams, useNavigate } from 'react-router-dom';
import { AddNewDeliveryAddress, ChangeUserPasswordById, DeleteDeliveryAdress, GetDeliveryAddress, GetUsersById } from '../../../callAPI/api';
import jwtDecode from 'jwt-decode';
import Cookies from 'js-cookie';
import Context from '../../../store/Context';
import { Button, Col, Form, Input, Menu, Row, Select } from 'antd';
import { UserOutlined, KeyOutlined, CloseOutlined } from '@ant-design/icons';
import '../profile/profileManager.scss'
import EditUserInfo from '../../../component/management/user/EditUserInfo';
import axios from 'axios';

const ProfileManager = () => {
    const context = useContext(Context);
    const isHiddenAutoCpl = context.isHiddenAutoCpl
    const isScreenSmaller1280 = context.isScreenSmaller1280
    const isScreenSmaller430 = context.isScreenSmaller430

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

    const [addressSaved, setAddressSaved] = useState(null);
    const [detailAddress, setDetailAddress] = useState("");
    const [provinceSelected, setProvinceSelected] = useState(null)
    const [districtSelected, setDistrictSelected] = useState(null)
    const [wardSelected, setWardSelected] = useState(null)
    const [radioAddressSelected, setRadioAddressSelected] = useState(null)
    const [isAddressDeliveryChange, setIsAddressDeliveryChange] = useState(false)
    const [addNewDetailAddress, setAddNewDetailAddress] = useState("");
    const [addNewProvinceSelected, setAddNewProvinceSelected] = useState(null)
    const [addNewDistrictSelected, setAddNewDistrictSelected] = useState(null)
    const [addNewWardSelected, setAddNewWardSelected] = useState(null)
    const [optionsSelectProvince, setOptionsSelectProvince] = useState(null)
    const [optionsSelectDistricts, setOptionsSelectDistricts] = useState(null)
    const [optionsSelectWards, setOptionsSelectWards] = useState(null)

    useEffect(() => {
        if (token) {
            getDeliveryAddress();
        }
    }, [isAddressDeliveryChange]);
    useEffect(() => {
        setIsAddressDeliveryChange(false)
    }, [isAddressDeliveryChange]);

    useEffect(() => {
        getDiaGioiHanhChinhVN();
    }, []);

    const getDiaGioiHanhChinhVN = () => {
        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promise = axios(Parameter);
        promise.then(function (result) {
            let data = JSON.parse(result.data)
            const transformedData = data.map(province => {
                const transformedProvince = {
                    ...province,
                    value: province.Name,
                    label: province.Name,
                    Districts: province.Districts.map(district => {
                        const transformedDistrict = {
                            ...district,
                            value: district.Name,
                            label: district.Name,
                            Wards: district.Wards.map(ward => ({
                                ...ward,
                                value: ward.Name,
                                label: ward.Name,
                            })),
                        };
                        return transformedDistrict;
                    }),
                };
                return transformedProvince;
            });

            setOptionsSelectProvince(transformedData)
            console.log(transformedData)
        });
    }

    const getDeliveryAddress = () => {
        if (token) {
            console.log('hi');
            console.log(token);
            let requestData = {
                token: token
            }
            GetDeliveryAddress(requestData).then((data) => {
                console.log(data.delivery_address);
                setAddressSaved(data.delivery_address)
            })
        }

    }

    const handleAddNewAddress = () => {
        const requestData = {
            token: token,
            detail_address: addNewDetailAddress,
            province: addNewProvinceSelected,
            district: addNewDistrictSelected,
            ward: addNewWardSelected
        }
        AddNewDeliveryAddress(requestData).then(() => {
            context.Message('success', 'Thêm địa chỉ giao hàng thành công!')
            setIsAddressDeliveryChange(true)
        })
    }
    const handleChangeAddNewProvince = (e) => {
        let findProvince = optionsSelectProvince.find((province) => {
            return province.Name === e
        })
        console.log(findProvince)
        setAddNewProvinceSelected(findProvince.Name)
        setOptionsSelectDistricts(findProvince.Districts)
    }

    const handleChangeAddNewDistrict = (e) => {
        let findDistrict = optionsSelectDistricts.find((district) => {
            return district.Name === e
        })
        console.log(findDistrict)
        setAddNewDistrictSelected(findDistrict.Name)
        setOptionsSelectWards(findDistrict.Wards)
    }

    const handleChangeAddNewWard = (e) => {
        let findWard = optionsSelectWards.find((ward) => {
            return ward.Name === e
        })
        console.log(findWard)
        setAddNewWardSelected(findWard.Name)
    }

    const handleRemoveAddress = (address_id) => {
        console.log(address_id);
        const requestData = {
            token: token,
            address_id: address_id
        }
        DeleteDeliveryAdress(requestData).then(data => {
            context.Message('success', 'Xóa địa chỉ giao hàng thành công!')
            setIsAddressDeliveryChange(true)

        })
    }

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
                setRadioAddressSelected(parseInt(response.default_address_id))
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
        setRadioAddressSelected(parseInt(values.defAddressID))

        console.log(values);

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
        <div className="flex justify-center h-[auto]  bg-gray-100">
            <div className="w-[1060px] h-auto bg-white p-8 rounded-lg shadow-md m-5 max-[600px]:px-0 ">
                <div className="flex max-[430px]:block">
                    <div className="w-[25%] max-[430px]:w-full">
                        <Menu
                            onClick={handleClick}
                            selectedKeys={[currentMenu]}
                            mode={isScreenSmaller430 ? 'horizontal' : 'inline'}
                        >
                            <Menu.Item key="info" icon={<UserOutlined />} className='max-[430px]:w-[33%]'>
                                {isScreenSmaller430 ? 'Thông tin' : 'Thông tin cá nhân'}
                            </Menu.Item>
                            <Menu.Item key="password" icon={<KeyOutlined />} className='max-[430px]:w-[33%]'>
                                {isScreenSmaller430 ? 'mật khẩu' : 'Thay đổi mật khẩu'}
                            </Menu.Item>
                        </Menu>
                    </div>
                    <div className="w-[60%] m-auto max-[430px]:w-[90%] max-[1200px]:w-[65%]">
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
                                    <p className="col-span-3 text-gray-600">Địa chỉ hiện tại:</p>
                                    <p className="col-span-5 text-gray-800 font-semibold">{userData.default_address}</p>
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
            {
                editModalVisible ?
                    <EditUserInfo
                        visible={editModalVisible}
                        onCancel={handleCancelEdit}
                        onSave={handleSaveUserInfo}
                        userData={userData}
                        addressSaved={addressSaved}
                        optionsSelectProvince={optionsSelectProvince}
                        optionsSelectWards={optionsSelectWards}
                        optionsSelectDistricts={optionsSelectDistricts}
                        setDetailAddress={setDetailAddress}
                        setProvinceSelected={setProvinceSelected}
                        setDistrictSelected={setDistrictSelected}
                        setWardSelected={setWardSelected}
                        setOptionsSelectDistricts={setOptionsSelectDistricts}
                        setOptionsSelectWards={setOptionsSelectWards}
                        isAddressDeliveryChange={isAddressDeliveryChange}
                        setIsAddressDeliveryChange={setIsAddressDeliveryChange}
                        getDeliveryAddress={getDeliveryAddress}
                        setRadioAddressSelected={setRadioAddressSelected}
                        radioAddressSelected={radioAddressSelected}


                    /> : null
            }

        </div >
    );
};

export default ProfileManager;

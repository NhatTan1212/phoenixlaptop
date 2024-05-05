import React, { useState, useContext, useEffect } from 'react';
import { Modal, Form, Button, Input, Radio, Row, Select, Col } from 'antd';
import 'tailwindcss/tailwind.css';
import { AddNewDeliveryAddress, DeleteDeliveryAdress, EditUserInfoById } from '../../../callAPI/api'
import { faPlus, faX } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { CloseOutlined } from '@ant-design/icons';
import Cookies from 'js-cookie';
import Context from '../../../store/Context';


const EditUserInfo = ({ detailAddress, wardSelected, districtSelected, provinceSelected, visible, onCancel, onSave, userData, addressSaved, isSelectingDeliveryAddress, setIsSelectingDeliveryAddress, optionsSelectProvince, optionsSelectWards,
    optionsSelectDistricts, setDetailAddress, setProvinceSelected, setDistrictSelected, setWardSelected, setOptionsSelectDistricts, setOptionsSelectWards,
    isAddressDeliveryChange, setIsAddressDeliveryChange, getDeliveryAddress, setRadioAddressSelected, radioAddressSelected }) => {


    const context = useContext(Context)
    const isHiddenAutoCpl = context.isHiddenAutoCpl


    const [form] = Form.useForm();
    const [loading, setLoading] = useState(false);

    const [name, setName] = useState(userData.name);
    const [email, setEmail] = useState(userData.email);
    const [phone, setPhone] = useState(userData.phone);
    const [defAddressID, setDefAddressID] = useState(radioAddressSelected);

    const [addNewDetailAddress, setAddNewDetailAddress] = useState("");
    const [addNewProvinceSelected, setAddNewProvinceSelected] = useState(null)
    const [addNewDistrictSelected, setAddNewDistrictSelected] = useState(null)
    const [addNewWardSelected, setAddNewWardSelected] = useState(null)

    const token = Cookies.get('token');

    const handleChangeName = (e) => {
        setName(e.target.value);
    };

    const handleChangePhone = (e) => {
        setPhone(e.target.value);
    };

    const handleAddNewAddress = () => {
        if (addNewDetailAddress === '') {

        }
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

            setAddNewDetailAddress('')
            setAddNewProvinceSelected(null)
            setAddNewDistrictSelected(null)
            setAddNewWardSelected(null)
        })
    }
    const handleChangeAddNewProvince = (e) => {
        let findProvince = optionsSelectProvince.find((province) => {
            return province.Name === e
        })
        setAddNewProvinceSelected(findProvince.Name)
        setAddNewDistrictSelected(null)
        setAddNewWardSelected(null)
        setOptionsSelectDistricts(findProvince.Districts)
    }

    const handleChangeAddNewDistrict = (e) => {
        let findDistrict = optionsSelectDistricts.find((district) => {
            return district.Name === e
        })
        setAddNewDistrictSelected(findDistrict.Name)
        setAddNewWardSelected(null)
        setOptionsSelectWards(findDistrict.Wards)
    }

    const handleChangeAddNewWard = (e) => {
        let findWard = optionsSelectWards.find((ward) => {
            return ward.Name === e
        })
        setAddNewWardSelected(findWard.Name)
    }

    const handleRemoveAddress = (address_id) => {
        if (address_id + '' === defAddressID + '') {
            return context.Message('error', 'Bạn không được xóa địa chỉ mặc định.')
        }
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
        if (token) {
            getDeliveryAddress();
        }
    }, [isAddressDeliveryChange]);

    useEffect(() => {
        setIsAddressDeliveryChange(false)
    }, [isAddressDeliveryChange]);

    const handleSave = () => {

        if (!name || !phone) {
            context.Message("warning", "Vui lòng điền đầy đủ thông tin.")
            form.validateFields()
        } else {
            form.validateFields().then((values) => {
                setLoading(true);

                const newUserInfo = {
                    id: userData.id,
                    name: values.name,
                    email: values.email,
                    phone: values.phone,
                    defAddressID: radioAddressSelected
                }

                const default_address = addressSaved.find(item => item.id === parseInt(radioAddressSelected))
                if (default_address?.detail_address) {
                    onSave(Object.assign(
                        newUserInfo,
                        {
                            id: userData.id,
                            default_address: default_address.detail_address + ', ' + default_address.province + ', ' + default_address.district + ', ' + default_address.ward

                        }))
                        .then(() => {
                            setLoading(false);
                            form.resetFields();
                            onCancel();
                        });
                } else {
                    setLoading(false);
                    context.Message('error', 'Vui lòng kiểm tra lại thông tin.')
                    return
                }

                EditUserInfoById(newUserInfo).then((data) => {
                    if (data.success) {
                        context.Message("success", "Cập nhật thông tin thành công.")
                    }
                })
            });
        }
    };

    return (
        <Modal
            open={visible}
            title="Chỉnh sửa thông tin cá nhân"
            onCancel={onCancel}
            footer={[
                <Button key="cancel" onClick={onCancel}>
                    Hủy
                </Button>,
                <Button key="save" type="primary" loading={loading} onClick={handleSave}>
                    Lưu thay đổi
                </Button>,
            ]}
            width={1200}
        >
            <Form
                form={form}
                initialValues={{ name, email, phone, defAddressID }}
                layout="vertical"
            >
                <Row gutter={[24, 24]}>
                    <Col span={8}>
                        <Form.Item
                            name="name"
                            label="Tên"
                            rules={[{ required: true, message: 'Vui lòng nhập tên' }]}
                        >
                            <Input
                                placeholder="Nhập Tên của bạn"
                                value={name}
                                onChange={handleChangeName}
                            />
                        </Form.Item>
                        <Form.Item
                            name="email"
                            label="Email"
                            rules={[
                                { required: true, message: 'Vui lòng nhập email' },
                                { type: 'email', message: 'Email không hợp lệ' },
                            ]}
                        >
                            <Input
                                disabled={true}
                                value={email}
                            />
                        </Form.Item>
                        <Form.Item
                            name="phone"
                            label="Số điện thoại"
                            rules={[{ required: true, message: 'Vui lòng nhập số điện thoại' }]}
                        >
                            <Input
                                placeholder="Nhập Số điện thoại của bạn"
                                value={phone}
                                onChange={handleChangePhone}
                            />
                        </Form.Item>
                    </Col>


                    <Col span={16}>
                        <Form.Item
                            name="defAddressID"
                            label="Địa chỉ hiện tại"
                            rules={[{ required: true, message: 'Vui lòng chọn địa chỉ mặc định' }]}
                            style={{ marginBottom: 0 }}
                        >
                            {addressSaved ? (
                                <div>
                                    <Radio.Group
                                        className='mb-3'
                                        onChange={(e) => {
                                            setRadioAddressSelected(e.target.value);
                                        }}
                                        value={radioAddressSelected || defAddressID}
                                        style={{ width: "100%", display: "block" }}
                                    >
                                        {addressSaved.map((address, index) => (
                                            <Row
                                                key={address.id}
                                                className={radioAddressSelected === address.id
                                                    ? 'flex justify-between hover:bg-[#f2f2f2] px-2 bg-[#f2f2f2] '
                                                    : 'flex justify-between hover:bg-[#f2f2f2] px-2'}>
                                                <Radio
                                                    closeIcon={<CloseOutlined />}
                                                    value={address.id}
                                                    className={radioAddressSelected === address.id
                                                        ? 'py-1 hover:text-red-700 text-red-700'
                                                        : 'py-1 hover:text-red-700'}>
                                                    Địa chỉ {index + 1}: {address.detail_address}, {address.province}, {address.district}, {address.ward}.
                                                </Radio>
                                                <span
                                                    className='text-gray-500 hover:text-red-700 my-auto hover:cursor-pointer hover:underline'
                                                    onClick={() => { handleRemoveAddress(address.id) }}>Xóa</span>
                                            </Row>
                                        ))}
                                    </Radio.Group>

                                    <div className='bg-[#f8f8f8] p-5 border-[1px] border-[#d4d4d4]'>
                                        <Input
                                            className='text-[15px]'
                                            value={addNewDetailAddress}
                                            onChange={(e) => {
                                                setAddNewDetailAddress(e.target.value)
                                            }}
                                            placeholder='Chi tiết tên đường, số nhà'></Input>
                                        <div className={`items-center justify-between ${isHiddenAutoCpl ? 'flex' : ''} `}>
                                            <Select
                                                className={` my-3 flex-1 mr-2 items-center  ${!isHiddenAutoCpl ? 'w-full mx-0' : 'ml-0'}`}
                                                showSearch
                                                value={addNewProvinceSelected || "Chọn Tỉnh/Thành phố"}
                                                options={optionsSelectProvince}
                                                onChange={(e) => handleChangeAddNewProvince(e)}
                                                filterOption={(input, option) =>
                                                    option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                }>
                                            </Select>
                                            <Select
                                                className={` my-3 flex-1  ${!isHiddenAutoCpl ? 'w-full mx-0' : 'mx-2'}`}
                                                showSearch
                                                value={addNewDistrictSelected || "Chọn Quận/Huyện"}
                                                options={optionsSelectDistricts}
                                                filterOption={(input, option) =>
                                                    option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                }
                                                onChange={(e) => handleChangeAddNewDistrict(e)}>
                                            </Select>
                                            <Select
                                                className={` my-3 flex-1  ${!isHiddenAutoCpl ? 'w-full mx-0' : 'mr-0'}`}
                                                showSearch
                                                value={addNewWardSelected || "Chọn Phường/Xã"}
                                                options={optionsSelectWards}
                                                filterOption={(input, option) =>
                                                    option.label.toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                }
                                                onChange={(e) => handleChangeAddNewWard(e)}>
                                            </Select>
                                        </div>
                                        {(addNewDetailAddress && addNewProvinceSelected && addNewDistrictSelected && addNewWardSelected) ?
                                            <Button className='mt-2' onClick={() => { handleAddNewAddress() }}>
                                                <FontAwesomeIcon icon={faPlus} />
                                                <span className='pl-1 font-bold hover:underline hover:cursor-pointer'>Thêm địa chỉ giao hàng</span>
                                            </Button> :
                                            <Button disabled className='btn-antd-disabled mt-2'>
                                                <FontAwesomeIcon icon={faPlus} />
                                                <span className='pl-1 font-bold hover:underline hover:cursor-pointer'>Thêm địa chỉ giao hàng</span>
                                            </Button>
                                        }
                                    </div>
                                </div>
                            ) : <p>Chưa có địa chỉ nào được lưu</p>}
                        </Form.Item>
                    </Col>
                </Row>
            </Form>

        </Modal>
    );
};

export default EditUserInfo;

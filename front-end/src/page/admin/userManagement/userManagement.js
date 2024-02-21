import React, { useState, useEffect, useContext } from 'react';
import { HomeOutlined, LaptopOutlined, InboxOutlined, PlusOutlined, } from '@ant-design/icons';
import {
    Breadcrumb, Input, Button, Table, Modal
} from 'antd';
import '../userManagement/userManagement.scss'
import { GetUsers, AddNewUser, EditUser, DeleteUser } from '../../../callAPI/api';
import ModalUserManager from '../../../component/management/ModalUserManager';
import Cookies from 'js-cookie';
import Context from '../../../store/Context';

const UserManagement = () => {
    let token = Cookies.get('token')
    const context = useContext(Context)
    const [users, setUsers] = useState([]);
    const [isEditing, setIsEditing] = useState(false);
    const [isViewing, setIsViewing] = useState(false);
    const [isOpenedModalAddNew, setIsOpenedModalAddNew] = useState(false);
    const [editingUser, setEditingUser] = useState(null);
    const [searchText, setSearchText] = useState('');
    const [filteredUsers, setFilteredUsers] = useState(users);
    const [showDeleteConfirmation, setShowDeleteConfirmation] = useState(false);
    const [userIdToDelete, setUserIdToDelete] = useState(null);
    const [isListUsersChanged, setIsListUsersChanged] = useState(false);
    const [role, setRole] = useState('user')

    const filtersRoles = [
        { text: 'Admin', value: 'admin' },
        { text: 'User', value: 'user' }
    ];

    const columns = [
        {
            title: 'ID',
            dataIndex: 'id',
            sorter: (record1, record2) => { return record1.id - record2.id }
        },
        {
            title: 'Name',
            dataIndex: 'name',
        },
        {
            title: 'Email',
            dataIndex: 'email',

        },

        {
            title: 'Role',
            dataIndex: 'role',
            filters: filtersRoles,
            onFilter: (value, record) => {
                return record.role === value;

            }
        },
        {
            title: 'Action',
            dataIndex: 'action',
            render: (text, record) => {
                return (<div className='flex flex-col h-auto'>
                    <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2'
                        onClick={(e) => {
                            console.log(record)
                            viewDetailsUser(record)
                        }}>
                        Xem chi tiết
                    </button>
                    <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
                        onClick={(e) => {
                            // console.log(record)
                            updateUser(record)
                        }}>
                        Chỉnh sửa
                    </button>
                    <button className=' bg-[#c8191f] text-white text-center
                    hover:text-white hover:shadow-[0_0_6px_0_#333] rounded-[30px] 
                    p-1 px-2 mt-2'
                        onClick={(e) => {
                            setUserIdToDelete(record.id)
                            setShowDeleteConfirmation(true)
                            setRole(record.role)
                            console.log(record.role)
                        }}>
                        Xóa
                    </button>
                </div>)
            }
        },
    ];

    useEffect(() => {
        // Hàm này chạy khi component được mount
        getUsers();

    }, [isEditing, searchText, isListUsersChanged]);

    useEffect(() => {
        filterUsers();
    }, [searchText, users]);

    const getUsers = () => {
        GetUsers().then((data) => {
            setUsers(data.search)
        })
    };

    const updateUser = (user) => {
        setIsEditing(true)
        setEditingUser(user)
    }

    const viewDetailsUser = (user) => {
        setIsViewing(true)
        setEditingUser(user)
    }

    const addNewUsers = () => {
        setIsOpenedModalAddNew(true)
    }

    const handleDeleteUser = (userId) => {

        const requestData = {
            token: token,
            user_id: userId,
        };

        DeleteUser(requestData).then(response => {
            if (response.success) {
                setIsListUsersChanged(!isListUsersChanged)
                context.Message("success", "Xóa tài khoản thành công.")

            }
        })
    }

    const handleChangeInputSearch = (e) => {
        setSearchText(e.target.value)

    }

    const filterUsers = () => {
        const filteredUsers = users.filter((user) => {
            const userName = user.name.toLowerCase();
            const userId = user.id + '';
            return userName.includes(searchText.toLowerCase()) || userId === searchText;
        });
        setFilteredUsers(filteredUsers);
    }


    return (
        <div className='flex-1'>
            <Modal
                title={role === 'user' ? "Xác nhận xóa tài khoản" : 'Thông báo'}
                open={showDeleteConfirmation}
                footer={
                    role === 'user' ? (
                        <div>
                            <Button
                                onClick={() => setShowDeleteConfirmation(false)}>
                                Cancel
                            </Button>
                            <Button
                                className='bg-[#e5101d] text-white' id='confirm-delete-user'
                                onClick={() => {
                                    handleDeleteUser(userIdToDelete);
                                    setShowDeleteConfirmation(false);
                                }}>
                                OK
                            </Button>
                        </div>
                    ) : null
                }
                onCancel={() => setShowDeleteConfirmation(false)}
                className='model-cart'
            >
                <p>{role === 'user' ?
                    'Bạn có chắc chắn muốn xóa tài khoản khỏi hệ thống?' :
                    'Bạn không thể xóa tài khoản Admin'}</p>
            </Modal>

            <div className='bg-[#f0f0f0] p-3'>
                <Breadcrumb
                    items={[
                        {
                            href: '',
                            title: <span className='flex items-center'>
                                <HomeOutlined />
                            </span>,
                        },
                        {
                            title: <span className='flex items-center'>
                                <LaptopOutlined className='mr-2' /> Users Management
                            </span>,
                        },
                    ]}
                />
                <div className='flex justify-between bg-white items-center p-4'>

                    <Input.Search
                        allowClear
                        className='searchPM'
                        placeholder='Nhập tài khoản, từ khóa cần tìm kiếm,...'
                        onChange={(e) => { handleChangeInputSearch(e) }}
                        style={{ width: '20%' }}></Input.Search>
                    <Button
                        className='btn-add-prd bg-[#c8191f] text-white 
                    h-auto'
                        onClick={() => { addNewUsers() }}
                    >
                        <span className='font-bold text-[18px] mr-2'>
                            +
                        </span>
                        <span>
                            Thêm tài khoản
                        </span>
                    </Button>
                </div>
                <div className='flex flex-col bg-white p-4
                mt-[20px]'>
                    <h3>Quản lý tài khoản</h3>
                    <Table
                        className='table-users-management'
                        columns={columns}
                        dataSource={filteredUsers.map((users) => ({
                            ...users,
                            key: users.id
                        }))}>
                    </Table>
                </div>
            </div>
            {isEditing &&
                <ModalUserManager
                    title={'Chỉnh sửa tài khoản - ' + editingUser.name}
                    isActioning={isEditing}
                    width={500}
                    actioningUser={editingUser}
                    setAcctioningUser={setEditingUser}
                    setIsActioning={setIsEditing}
                    searchText={searchText}
                ></ModalUserManager>
            }
            {isViewing &&
                <ModalUserManager
                    title={'Xem chi tiết tài khoản - ' + editingUser.name}
                    width={500}
                    isActioning={isViewing}
                    actioningUser={editingUser}
                    setAcctioningUser={setEditingUser}
                    setIsActioning={setIsViewing}
                ></ModalUserManager>
            }
            {isOpenedModalAddNew &&
                <ModalUserManager
                    title={'Thêm tài khoản mới'}
                    isActioning={isOpenedModalAddNew}
                    width={800}
                    setIsActioning={setIsOpenedModalAddNew}
                ></ModalUserManager>
            }

        </div>

    );
};
export default UserManagement;
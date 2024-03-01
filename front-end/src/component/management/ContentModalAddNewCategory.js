import { AddNewCategory } from '../../callAPI/api';
import React, { useState, useContext } from 'react';
import {
    Input, Select, Row, Col
} from 'antd';
import '../../component/management/modalFPM.scss'
import Cookies from 'js-cookie';
import Context from '../../store/Context';
import { EyeInvisibleOutlined, EyeTwoTone } from '@ant-design/icons';
import TextArea from 'antd/es/input/TextArea';


const ContentModalAddNewCategory = ({ setIsActioning }) => {
    let token = Cookies.get('token');
    const context = useContext(Context);
    const [name, setName] = useState('');
    const [description, setDescription] = useState('');
    const [hasNameChanged, setHasNameChanged] = useState(false);
    const [hasDescriptionChanged, setHasDescriptionChanged] = useState(false);
    const [newCategoryFailed, setNewCategoryFailed] = useState(false);
    const [nameIsNull, setNameIsNull] = useState(false);
    const [descriptionIsNull, setDescriptionIsNull] = useState(false);

    const onChangeName = (e) => {
        setName(e.target.value);
        setHasNameChanged(true)
        setNameIsNull(false);
    }

    const onChangeDescription = (e) => {
        setDescription(e.target.value)
        setHasDescriptionChanged(true);
        setDescriptionIsNull(false);
    };

    const onFinish = (values) => {

        values.preventDefault();
        const formData = {
            token: token,
            name: name,
            description: description
        }

        let hasError = false;
        if (!name) {
            setNameIsNull(true);
            hasError = true;
        }
        if (!description) {
            setDescriptionIsNull(true);
            hasError = true;
        }

        if (hasError) {
            setNewCategoryFailed(true);
            context.Message("warning", "Vui lòng điền đầy đủ thông tin");
            return;
        }

        AddNewCategory(formData).then(response => {
            console.log(response)
            if (response.success) {
                context.Message("success", response.message)
                setIsActioning(false);
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
                        <Col span={24} className='text-start px-[15px] pl-0'>

                            <h3><span className='text-red-500'>* </span>Tên danh mục:</h3>
                            <Input
                                className='mb-2 mt-0'
                                name='name'
                                onChange={(e) => { onChangeName(e) }}
                                value={name}
                            />

                            <div className='wrap-err-mess'>
                                {(hasNameChanged && name === '') || (newCategoryFailed && nameIsNull)
                                    ? <p className='err-mess'>Tên danh mục không được để trống</p> : null}
                            </div>

                            <h3><span className='text-red-500'>* </span>Mô tả:</h3>
                            <TextArea
                                rows={5}
                                className='mb-2 mt-0 input-description-edituserdetails'
                                name='description'
                                value={description}
                                onChange={(e) => {
                                    onChangeDescription(e)
                                }} />
                            <div className='wrap-err-mess'>
                                {(hasDescriptionChanged && description === '') || (newCategoryFailed && descriptionIsNull)
                                    ? <p className='err-mess'>Mô tả không được để trống</p> : null
                                }
                            </div>
                        </Col>
                    </Row>

                    <div className='inline-block mt-5'>
                        <Input type='submit' defaultValue={"Thêm danh mục"}
                            className='bg-[#c8191f] text-white'>
                        </Input>
                    </div>
                </form>
            </div>
        </div>
    )
}

export default ContentModalAddNewCategory
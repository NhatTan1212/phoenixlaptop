import Instance from '../../axiosInstance';

const GetOrderSuccessByDays = (days) => {
    return Instance.post('/order-success-by-date', { days })
        .then((res) => res.data)
        .catch((err) => {
            console.log('Lỗi call API GetOrderSuccessByDays: ' + err);
            return Promise.reject(err);
        });
};



const GetNewOrderByDays = (days) => {
    return Instance.post('/new-order-by-date', { days })
        .then((res) => res.data)
        .catch((err) => {
            console.log('Loi call api GetOrderSuccessByDays: ' + err);
            return Promise.reject(err);
        });
};

const GetNewUserByDays = (days) => {
    return Instance.post('/new-user-by-date', { days })
        .then((res) => res.data)
        .catch((err) => {
            console.log('Loi call api GetUserSuccessByDays: ' + err);
            return Promise.reject(err);
        });
};

const GetFavoriteBrandsByDays = (days) => {
    return Instance.post('/favorite-brands', { days })
        .then((res) => res.data)
        .catch((err) => {
            console.log('Loi call api GetFavoriteBrandsByDays: ' + err);
            return Promise.reject(err);
        });
};

const GetFavoriteLaptopsByDays = (days) => {
    return Instance.post('/favorite-laptops', { days })
        .then((res) => res.data)
        .catch((err) => {
            console.log('Loi call api GetFavoriteLaptopsByDays: ' + err);
            return Promise.reject(err);
        });
};

export { GetOrderSuccessByDays, GetNewOrderByDays, GetNewUserByDays, GetFavoriteBrandsByDays, GetFavoriteLaptopsByDays }
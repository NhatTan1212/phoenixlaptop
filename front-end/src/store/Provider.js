import Context from "./Context";
import { useState } from "react";
import { message } from "antd";

function Provider({ children }) {
    const [isCartChange, setIsCartChange] = useState(false);
    const [isShowFloatLayer, setIsShowFloatLayer] = useState(false);
    const [messageApi, contextHolder] = message.useMessage();
    const [isFinishAddNewOrderVNPAY, setIsFinishAddNewOrderVNPAY] = useState(false);
    const Message = (type, text) => {
        messageApi.open({
            type: type,
            content: text,
        });
    };

    return (
        <Context.Provider value={{ isCartChange, setIsCartChange, Message, isShowFloatLayer, setIsShowFloatLayer, isFinishAddNewOrderVNPAY, setIsFinishAddNewOrderVNPAY }}>
            {contextHolder}
            {children}
        </Context.Provider>
    )
}

export default Provider
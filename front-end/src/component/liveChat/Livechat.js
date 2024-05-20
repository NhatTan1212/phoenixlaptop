import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faWindowMinimize } from '@fortawesome/free-solid-svg-icons';
import { faFacebookMessenger } from '@fortawesome/free-brands-svg-icons';
import React, { useState, useRef, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import Cookies from 'js-cookie';
import jwtDecode from 'jwt-decode';
import '../liveChat/LiveChat.scss';

function Livechat() {
    const token = Cookies.get('token');
    const location = useLocation();
    const [isAdmin, setIsAdmin] = useState(false);
    const [isOpen, setIsOpen] = useState(false);
    const [hoverOptions, setHoverOptions] = useState(false);
    const [selectedChat, setSelectedChat] = useState('staff');
    const [animationClass, setAnimationClass] = useState('');
    const [chatSelectClass, setChatSelectClass] = useState('')
    const chatRef = useRef(null);
    const buttonRef = useRef(null);

    const toggleChat = () => {
        if (isOpen) {
            setAnimationClass('animate-zoomOut');
            setTimeout(() => {
                setIsOpen(false);
                setSelectedChat(null);
            }, 300);
        }
    };

    const closeChat = () => {
        setAnimationClass('animate-zoomOut');
        setTimeout(() => {
            setIsOpen(false);
            setSelectedChat(null);
        }, 300);
    };

    useEffect(() => {
        if (token) {
            const decodedToken = jwtDecode(token);
            if (decodedToken.role === 'admin') {
                setIsAdmin(true);
            }
        } else {
            setIsAdmin(false);
        }
    }, [location]);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (chatRef.current && !chatRef.current.contains(event.target) && !buttonRef.current.contains(event.target)) {
                setAnimationClass('animate-zoomOut');
                setTimeout(() => {
                    setIsOpen(false);
                    setSelectedChat(null);
                }, 300);
            }
        };

        document.addEventListener("mousedown", handleClickOutside);
        return () => {
            document.removeEventListener("mousedown", handleClickOutside);
        };
    }, []);

    const handleHover = () => {
        if (!isOpen) {
            setChatSelectClass('showOptions');
            setHoverOptions(true);
        }
    };

    const handleLeave = () => {
        setChatSelectClass('hideOptions')
        setHoverOptions(false);
    };

    const handleOptionClick = (option) => {
        setSelectedChat(option);
        setIsOpen(true);
        setAnimationClass('animate-zoomIn');
    };

    const getChatLink = () => {
        return selectedChat === 'staff' ? 'https://m.me/277034358822420' : 'https://m.me/336033506252838';
    };

    return (
        !isAdmin && (
            <div className="fixed bottom-6 right-6 z-50">
                <div
                    className="relative"
                    onMouseLeave={handleLeave}
                    ref={buttonRef}
                >
                    <div className="w-16 h-16 flex items-center justify-center bg-red-500 shadow-md transition-all duration-300 rounded-full hover:bg-red-400 cursor-pointer"
                        onClick={toggleChat}
                        onMouseEnter={handleHover}
                    >
                        <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-4xl" />
                    </div>
                    {hoverOptions &&
                        <div className={`chatOption absolute bottom-16 right-0 pb-4 flex flex-col items-end space-y-3 ${chatSelectClass}`}>
                            <button
                                className="text-xl px-6 py-2 bg-red-500 text-white hover:bg-red-400 shadow-lg rounded-xl whitespace-nowrap option"
                                onClick={() => handleOptionClick('staff')}
                            >
                                Gặp nhân viên hỗ trợ
                            </button>
                            <button
                                className="text-xl px-6 py-2 bg-white text-red-500 hover:bg-gray-100 shadow-lg rounded-xl whitespace-nowrap option"
                                onClick={() => handleOptionClick('ai')}
                            >
                                Chatbot AI
                            </button>
                        </div>
                    }

                </div>

                {isOpen && (
                    <div
                        className={`absolute bottom-16 pb-4 right-0 ${animationClass}`}
                        ref={chatRef}
                    >
                        <div className={`w-[450px] ${selectedChat === 'staff' ? 'h-[430px]' : 'h-[500px]'} bg-white shadow-xl rounded-xl overflow-hidden`}>
                            <div className="flex items-center justify-between bg-red-500 p-4 rounded-t-lg">
                                <div className="flex items-center">
                                    <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-3xl" />
                                    <h2 className="text-white text-2xl font-semibold pl-5">
                                        {selectedChat === 'staff' ? 'Phoenix Laptop' : 'Phoenix AI'}
                                    </h2>
                                </div>
                                <button onClick={closeChat} className="text-white pb-2 hover:text-gray-700 focus:outline-none">
                                    <FontAwesomeIcon icon={faWindowMinimize} />
                                </button>
                            </div>

                            <div className={`w-full h-[80%] flex flex-col justify-between`}>
                                <div className='bg-red-500 px-3 py-5'>
                                    {selectedChat === 'staff'
                                        ? (
                                            <>
                                                <div className='text-white px-2 mb-2 text-4xl font-bold'>Chào bạn!</div>
                                                <div className='text-white px-2 text-lg italic'>Vui lòng nhấn nút bên dưới để nhận được hỗ trợ trực tiếp từ các nhân viên.</div>
                                            </>
                                        )
                                        : (
                                            <>
                                                <div className='text-white px-2 mb-2 text-4xl font-bold'>Xin chào!</div>
                                                <div className='text-white px-2 text-lg italic'>Tôi là Chatbot AI chuyên tư vấn laptop, sẵn sàng giúp bạn tìm ra chiếc laptop hoàn hảo nhất cho nhu cầu của bạn.</div>
                                            </>
                                        )
                                    }
                                </div>
                                <div className='flex flex-col items-center'>
                                    {selectedChat === 'staff'
                                        ? <div className={`text-center text-xl text-gray-500 px-5 ${selectedChat === 'staff' ? 'mt-5' : 'mb-5'}`}>Bắt đầu trò chuyện với nhân viên</div>
                                        : <div className='text-center text-xl text-gray-500 px-5 mb-1'>Hãy nhấn nút bên dưới để nhận được sự hỗ trợ tận tình từ tôi ngay bây giờ!</div>
                                    }

                                    <div className='w-[70%] p-5 m-6 rounded-3xl flex items-center justify-evenly bg-red-500 hover:bg-red-400 hover:shadow-xl cursor-pointer transition-all duration-300'>
                                        <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-3xl" />
                                        <Link
                                            className='text-xl text-white font-semibold'
                                            to={getChatLink()}
                                            target="_blank"
                                            onClick={toggleChat}
                                        >
                                            Chat trên Messenger
                                        </Link>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        )
    );
}

export default Livechat;

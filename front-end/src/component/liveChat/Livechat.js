import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faWindowMinimize } from '@fortawesome/free-solid-svg-icons';
import { faFacebookMessenger } from '@fortawesome/free-brands-svg-icons';
import React, { useState, useRef, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import Cookies from 'js-cookie';
import jwtDecode from 'jwt-decode';

function Livechat() {
    const token = Cookies.get('token');
    const location = useLocation();
    const [isAdmin, setIsAdmin] = useState(false)
    const [isOpen, setIsOpen] = useState(false);
    const chatRef = useRef(null);

    const toggleChat = () => {
        setIsOpen(!isOpen);
    };

    const closeChat = () => {
        setIsOpen(false);
    };

    useEffect(() => {
        if (token) {
            const decodedToken = jwtDecode(token);
            if (decodedToken.role === 'admin') {
                setIsAdmin(true)
            }
        } else {
            setIsAdmin(false)
        }
    }, [location])


    useEffect(() => {
        const handleClickOutside = (event) => {
            if (chatRef.current && !chatRef.current.contains(event.target)) {
                setIsOpen(false);
            }
        };

        document.addEventListener("mousedown", handleClickOutside);
        return () => {
            document.removeEventListener("mousedown", handleClickOutside);
        };
    }, []);

    return (
        !isAdmin && (
            <div className="fixed bottom-6 right-6 z-[100]">
                {!isOpen && (
                    <div
                        className="w-16 h-16 flex items-center justify-center bg-red-500 shadow-md transition-all duration-300 rounded-full hover:bg-red-400 cursor-pointer"
                        onClick={toggleChat}
                    >
                        <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-4xl" />
                    </div>
                )}
                {isOpen && (
                    <div className="absolute bottom-0 right-0" ref={chatRef}>
                        <div className="w-[350px] bg-white shadow-xl rounded-xl overflow-hidden">
                            <div className="flex items-center justify-between mb-4 bg-red-500 p-4 rounded-t-lg">
                                <div className="flex items-center">
                                    <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-3xl" />
                                    <h2 className="text-white text-lg font-semibold pl-5">Phoenix Laptop</h2>
                                </div>
                                <button onClick={closeChat} className="text-white pb-2 hover:text-gray-700 focus:outline-none">
                                    <FontAwesomeIcon icon={faWindowMinimize} />
                                </button>
                            </div>
                            <div className='px-5 py-2'>
                                <span className='text-2xl font-bold'>Chat với Phoenix Laptop</span>
                            </div>
                            <div className='px-5 pb-8'>
                                <span className='text-lg'>Xin chào! Tôi có thể giúp gì cho bạn?</span>
                            </div>
                            <div className='p-5 m-6 rounded-3xl flex items-center justify-evenly bg-red-500 hover:bg-red-400 hover:shadow-xl cursor-pointer transition-all duration-300'>
                                <FontAwesomeIcon icon={faFacebookMessenger} className="text-white text-3xl" />
                                <Link
                                    className='text-xl text-white font-semibold'
                                    to='https://m.me/277034358822420'
                                    target="_blank"
                                >
                                    Chat trên Messenger
                                </Link>
                            </div>
                        </div>
                    </div>
                )}
            </div>
        )
    );
}

export default Livechat;

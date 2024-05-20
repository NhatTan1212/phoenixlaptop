import React, { useEffect } from 'react';
import Header from './component/header/header';
import Footer from './component/footer/footer';
import Content from './component/content/Content';
import './App.scss'
import Livechat from './component/liveChat/Livechat';



function App() {
  return (
    <>

      <Header />
      <Content></Content>
      <Livechat />
      <Footer />

    </>
  );
}

export default App;
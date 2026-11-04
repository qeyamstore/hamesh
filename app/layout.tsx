import type { Metadata } from 'next';import './globals.css';
export const metadata:Metadata={title:'هامش | ربحية متاجر سلة',description:'مساحة مستقلة لكل متجر. افهم المبيعات والتكاليف والربح في مكان واحد.'};
export default function Layout({children}:{children:React.ReactNode}){return <html lang="ar" dir="rtl"><body>{children}</body></html>}

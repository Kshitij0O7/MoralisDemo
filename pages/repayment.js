import { Header, Footer } from '../src/components/modules';
export default function Repayment() {
  return (
    <div>
      <Header />
      <div className="repayment-section">
        <div className="repayment-card">
          <div className="repayment-content">
            <h1>Ethereum Bank</h1>
            <h3>Total Payable Amount: $50000</h3>
            <h4>Base Amount: $45000</h4>
            <h4>Duration of the loan: 5 years</h4>
            <h4>Interest Added: $5000</h4>
            <a className="repayment-button">Repay Now</a>
          </div>
          <div className="repayment-card-logo">
            <img src="https://i.pinimg.com/originals/ff/d5/31/ffd531a6a78464512a97848e14506738.png"></img>
          </div>
        </div>
      </div>
      <div className="repayment-section">
        <div className="repayment-card">
          <div className="repayment-content">
            <h1>Ethereum Bank</h1>
            <h3>Total Payable Amount: $50000</h3>
            <h4>Base Amount: $45000</h4>
            <h4>Duration of the loan: 5 years</h4>
            <h4>Interest Added: $5000</h4>
            <a className="repayment-button">Repay Now</a>
          </div>
          <div className="repayment-card-logo">
            <img src="https://i.pinimg.com/originals/ff/d5/31/ffd531a6a78464512a97848e14506738.png"></img>
          </div>
        </div>
      </div>
      <Footer />
    </div>
  );
}

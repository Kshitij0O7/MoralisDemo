// import { getBankList } from "../../../../backend/contracts/Dbank.sol"
import {Header, Footer} from "../src/components/modules"
export default function RequestLoan() {
    return (
        <div>
            <Header />
            <div className="bank-loan-details">
                <div className="bank-loan-detail-card">
                    <div className="bank-card-content">
                        <h1 className="bank-name">ETHEREUM BANK</h1>
                        <h3 className="bank-interest-rate">INTEREST RATE : 2%</h3> 
                        <a className="request-loan-button">RequestLoan</a>  
                    </div>
                    <div className="bank-card-logo">
                        <img src="https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/6dab2f9e01e4bb467ce4416015c323e8"></img>
                    </div>
                    
                </div>
                <div className="bank-loan-detail-card">
                    <div className="bank-card-content"> 
                        <h1>ETHEREUM BANK</h1>
                        <h3>INTEREST RATE : 2%</h3>   
                    </div>
                    <div className="bank-card-logo">
                        <img src="https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/6dab2f9e01e4bb467ce4416015c323e8"></img>
                    </div>
                </div>
                <div className="bank-loan-detail-card">
                    <div className="bank-card-content">
                        <h1>ETHEREUM BANK</h1>
                        <h3>INTEREST RATE : 2%</h3>   
                    </div>
                    <div className="bank-card-logo">
                        <img src="https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/6dab2f9e01e4bb467ce4416015c323e8"></img>
                    </div>
                </div>
                <div className="bank-loan-detail-card">
                    <div className="bank-card-content">
                        <h1>ETHEREUM BANK</h1>
                        <h3>INTEREST RATE : 2%</h3>   
                    </div>
                    <div className="bank-card-logo">
                        <img src="https://d2q79iu7y748jz.cloudfront.net/s/_squarelogo/6dab2f9e01e4bb467ce4416015c323e8"></img>
                    </div>
                </div>
            </div>
            <Footer/>
        </div>
        
    )
}

function calcProfit(){
  const priceStr = document.getElementById('item-price');
  priceStr.addEventListener('input', () => {

    let priceNum = 0;
    let tax = 0;
    let profit = 0;

    priceNum = parseInt(priceStr.value);

    if(priceNum >= 0 && priceStr.value != '') {

      taxElem = document.getElementById('add-tax-price');
      profitElem = document.getElementById('profit');
  
      tax = Math.floor(priceNum * 10 / 100);
      profit = priceNum - tax;
    }
  
    taxElem.innerHTML = tax;
    profitElem.innerHTML = profit;
  });
}


window.addEventListener('load', calcProfit);
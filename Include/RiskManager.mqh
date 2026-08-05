//+------------------------------------------------------------------+
//| RiskManager.mqh                                                  |
//+------------------------------------------------------------------+
#ifndef __RISK_MANAGER_MQH__
#define __RISK_MANAGER_MQH__

//====================================================
// Calculate Lot Size
//====================================================
double CalculateLot(double stopLossPoints)
{
   if(stopLossPoints<=0)
      return(SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));

   double balance=AccountInfoDouble(ACCOUNT_BALANCE);

   double riskMoney=balance*(RiskPercent/100.0);

   double tickValue=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);
   double tickSize =SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);

   if(tickValue<=0 || tickSize<=0)
      return(SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN));

   double pointValue=tickValue/tickSize;

   double lot=riskMoney/(stopLossPoints*pointValue);

   double minLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double maxLot=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   double step  =SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

   lot=MathMax(minLot,lot);
   lot=MathMin(maxLot,lot);

   lot=MathFloor(lot/step)*step;

   return NormalizeDouble(lot,2);
}

//====================================================
// Check Free Margin
//====================================================
bool MarginOK(double lot)
{
   double margin=0;

   if(!OrderCalcMargin(
      ORDER_TYPE_BUY,
      _Symbol,
      lot,
      SymbolInfoDouble(_Symbol,SYMBOL_ASK),
      margin))
      return(false);

   return(AccountInfoDouble(ACCOUNT_FREEMARGIN)>margin);
}

//====================================================
// Daily Loss (%)
//====================================================
double DailyLossPercent(double startBalance)
{
   double equity=AccountInfoDouble(ACCOUNT_EQUITY);

   if(startBalance<=0)
      return(0);

   return((startBalance-equity)/startBalance)*100.0;
}

#endif

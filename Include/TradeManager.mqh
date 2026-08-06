//+------------------------------------------------------------------+
//| TradeManager.mqh                                                 |
//+------------------------------------------------------------------+
#ifndef __TRADE_MANAGER_MQH__
#define __TRADE_MANAGER_MQH__

#include <Trade/Trade.mqh>

extern CTrade trade;

//====================================================
// Open Buy
//====================================================
bool BuyPosition(double lot,double sl,double tp)
{
   trade.SetExpertMagicNumber(MagicNumber);

   return trade.Buy(
      lot,
      _Symbol,
      SymbolInfoDouble(_Symbol,SYMBOL_ASK),
      sl,
      tp,
      "SMC BUY"
   );
}

//====================================================
// Open Sell
//====================================================
bool SellPosition(double lot,double sl,double tp)
{
   trade.SetExpertMagicNumber(MagicNumber);

   return trade.Sell(
      lot,
      _Symbol,
      SymbolInfoDouble(_Symbol,SYMBOL_BID),
      sl,
      tp,
      "SMC SELL"
   );
}

//====================================================
// Move To BreakEven
//====================================================
void BreakEven()
{
   if(!PositionSelect(_Symbol))
      return;

   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double sl        = PositionGetDouble(POSITION_SL);
   double tp        = PositionGetDouble(POSITION_TP);

   ENUM_POSITION_TYPE type =
      (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

   if(type==POSITION_TYPE_BUY)
   {
      double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);

      if((bid-openPrice)>=BreakEvenPoints*_Point)
      {
         if(sl<openPrice)
            trade.PositionModify(_Symbol,openPrice,tp);
      }
   }

   if(type==POSITION_TYPE_SELL)
   {
      double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);

      if((openPrice-ask)>=BreakEvenPoints*_Point)
      {
         if(sl>openPrice || sl==0)
            trade.PositionModify(_Symbol,openPrice,tp);
      }
   }
}

//====================================================
// Trailing Stop
//====================================================
void TrailStop()
{
   if(!PositionSelect(_Symbol))
      return;

   double tp = PositionGetDouble(POSITION_TP);

   ENUM_POSITION_TYPE type =
      (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

   if(type==POSITION_TYPE_BUY)
   {
      double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      double newSL = bid-(TrailingStop*_Point);

      if(newSL>PositionGetDouble(POSITION_SL))
         trade.PositionModify(_Symbol,newSL,tp);
   }

   if(type==POSITION_TYPE_SELL)
   {
      double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
      double newSL = ask+(TrailingStop*_Point);

      if(newSL<PositionGetDouble(POSITION_SL) ||
         PositionGetDouble(POSITION_SL)==0)
      {
         trade.PositionModify(_Symbol,newSL,tp);
      }
   }
}

//====================================================
// Check Existing Position
//====================================================
bool HasOpenPosition()
{
   return PositionSelect(_Symbol);
}

#endif



//+------------------------------------------------------------------+
//| OrderBlockDetector.mqh                                           |
//+------------------------------------------------------------------+
#ifndef __ORDERBLOCK_DETECTOR_MQH__
#define __ORDERBLOCK_DETECTOR_MQH__

struct ORDER_BLOCK
{
   double High;
   double Low;
   datetime Time;
   bool Bullish;
   bool Valid;
};

//======================================================
// Bullish Order Block
//======================================================
ORDER_BLOCK GetBullishOrderBlock()
{
   ORDER_BLOCK ob;
   ob.Valid=false;

   for(int i=5;i<100;i++)
   {
      double open=iOpen(_Symbol,EntryTF,i);
      double close=iClose(_Symbol,EntryTF,i);

      if(close<open)
      {
         double nextClose=iClose(_Symbol,EntryTF,i-1);

         if(nextClose>iHigh(_Symbol,EntryTF,i))
         {
            ob.High=iHigh(_Symbol,EntryTF,i);
            ob.Low=iLow(_Symbol,EntryTF,i);
            ob.Time=iTime(_Symbol,EntryTF,i);
            ob.Bullish=true;
            ob.Valid=true;
            return ob;
         }
      }
   }

   return ob;
}

//======================================================
// Bearish Order Block
//======================================================
ORDER_BLOCK GetBearishOrderBlock()
{
   ORDER_BLOCK ob;
   ob.Valid=false;

   for(int i=5;i<100;i++)
   {
      double open=iOpen(_Symbol,EntryTF,i);
      double close=iClose(_Symbol,EntryTF,i);

      if(close>open)
      {
         double nextClose=iClose(_Symbol,EntryTF,i-1);

         if(nextClose<iLow(_Symbol,EntryTF,i))
         {
            ob.High=iHigh(_Symbol,EntryTF,i);
            ob.Low=iLow(_Symbol,EntryTF,i);
            ob.Time=iTime(_Symbol,EntryTF,i);
            ob.Bullish=false;
            ob.Valid=true;
            return ob;
         }
      }
   }

   return ob;
}

//======================================================
// Price In Bullish OB
//======================================================
bool PriceInsideBullishOB()
{
   ORDER_BLOCK ob=GetBullishOrderBlock();

   if(!ob.Valid)
      return false;

   double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);

   return(bid>=ob.Low && bid<=ob.High);
}

//======================================================
// Price In Bearish OB
//======================================================
bool PriceInsideBearishOB()
{
   ORDER_BLOCK ob=GetBearishOrderBlock();

   if(!ob.Valid)
      return false;

   double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);

   return(ask>=ob.Low && ask<=ob.High);
}

//======================================================
// Buy Confirmation
//======================================================
bool BullishOBConfirmed()
{
   return(GetBullishOrderBlock().Valid &&
          PriceInsideBullishOB());
}

//======================================================
// Sell Confirmation
//======================================================
bool BearishOBConfirmed()
{
   return(GetBearishOrderBlock().Valid &&
          PriceInsideBearishOB());
}

#endif

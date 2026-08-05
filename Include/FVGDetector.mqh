//+------------------------------------------------------------------+
//| FVGDetector.mqh                                                  |
//+------------------------------------------------------------------+
#ifndef __FVG_DETECTOR_MQH__
#define __FVG_DETECTOR_MQH__

struct FVG_ZONE
{
   double High;
   double Low;
   datetime Time;
   bool Bullish;
   bool Valid;
};

//=====================================================
// Bullish FVG
//=====================================================
FVG_ZONE GetBullishFVG()
{
   FVG_ZONE fvg;
   fvg.Valid=false;

   for(int i=3;i<100;i++)
   {
      double firstHigh=iHigh(_Symbol,EntryTF,i);
      double thirdLow=iLow(_Symbol,EntryTF,i-2);

      if(thirdLow>firstHigh)
      {
         fvg.High=thirdLow;
         fvg.Low=firstHigh;
         fvg.Time=iTime(_Symbol,EntryTF,i-1);
         fvg.Bullish=true;
         fvg.Valid=true;
         return fvg;
      }
   }

   return fvg;
}

//=====================================================
// Bearish FVG
//=====================================================
FVG_ZONE GetBearishFVG()
{
   FVG_ZONE fvg;
   fvg.Valid=false;

   for(int i=3;i<100;i++)
   {
      double firstLow=iLow(_Symbol,EntryTF,i);
      double thirdHigh=iHigh(_Symbol,EntryTF,i-2);

      if(thirdHigh<firstLow)
      {
         fvg.High=firstLow;
         fvg.Low=thirdHigh;
         fvg.Time=iTime(_Symbol,EntryTF,i-1);
         fvg.Bullish=false;
         fvg.Valid=true;
         return fvg;
      }
   }

   return fvg;
}

//=====================================================
// Price Inside Bullish FVG
//=====================================================
bool PriceInsideBullishFVG()
{
   FVG_ZONE fvg=GetBullishFVG();

   if(!fvg.Valid)
      return(false);

   double bid=SymbolInfoDouble(_Symbol,SYMBOL_BID);

   return(bid>=fvg.Low && bid<=fvg.High);
}

//=====================================================
// Price Inside Bearish FVG
//=====================================================
bool PriceInsideBearishFVG()
{
   FVG_ZONE fvg=GetBearishFVG();

   if(!fvg.Valid)
      return(false);

   double ask=SymbolInfoDouble(_Symbol,SYMBOL_ASK);

   return(ask>=fvg.Low && ask<=fvg.High);
}

//=====================================================
// Confirmation
//=====================================================
bool BullishFVGConfirmed()
{
   return(GetBullishFVG().Valid &&
          PriceInsideBullishFVG());
}

bool BearishFVGConfirmed()
{
   return(GetBearishFVG().Valid &&
          PriceInsideBearishFVG());
}

#endif

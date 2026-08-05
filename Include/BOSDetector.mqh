//+------------------------------------------------------------------+
//| BOSDetector.mqh                                                  |
//+------------------------------------------------------------------+
#ifndef __BOS_DETECTOR_MQH__
#define __BOS_DETECTOR_MQH__

#include "SwingDetector.mqh"

//=====================================================
// Bullish BOS
//=====================================================
bool BullishBOS()
{
   double swingHigh = GetLastSwingHigh();

   if(swingHigh==0.0)
      return(false);

   double close1=iClose(_Symbol,EntryTF,1);

   return(close1>swingHigh);
}

//=====================================================
// Bearish BOS
//=====================================================
bool BearishBOS()
{
   double swingLow = GetLastSwingLow();

   if(swingLow==0.0)
      return(false);

   double close1=iClose(_Symbol,EntryTF,1);

   return(close1<swingLow);
}

//=====================================================
// BOS Direction
// 1 = Bullish
//-1 = Bearish
// 0 = None
//=====================================================
int BOSDirection()
{
   if(BullishBOS())
      return 1;

   if(BearishBOS())
      return -1;

   return 0;
}

//=====================================================
// BOS Price
//=====================================================
double BOSPrice()
{
   if(BullishBOS())
      return(GetLastSwingHigh());

   if(BearishBOS())
      return(GetLastSwingLow());

   return 0.0;
}

//=====================================================
// BOS Time
//=====================================================
datetime BOSTime()
{
   for(int i=SwingLength+2;i<300;i++)
   {
      if(BullishBOS() && IsSwingHigh(i,SwingLength))
         return(iTime(_Symbol,EntryTF,i));

      if(BearishBOS() && IsSwingLow(i,SwingLength))
         return(iTime(_Symbol,EntryTF,i));
   }

   return 0;
}

#endif

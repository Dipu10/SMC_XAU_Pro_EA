//+------------------------------------------------------------------+
//| Inputs.mqh                                                       |
//+------------------------------------------------------------------+
#ifndef __INPUTS_MQH__
#define __INPUTS_MQH__

//====================================================
// General
//====================================================
input group "General"

input ulong MagicNumber = 20260805;

input double RiskPercent = 1.0;
input double RiskReward  = 3.0;

input bool AllowBuy = true;
input bool AllowSell = true;

//====================================================
// TimeFrames
//====================================================
input group "TimeFrames"

input ENUM_TIMEFRAMES TrendTF = PERIOD_H4;
input ENUM_TIMEFRAMES EntryTF = PERIOD_M15;

//====================================================
// Trend Filter
//====================================================
input group "Trend Filter"

input int FastEMA = 50;
input int SlowEMA = 200;

//====================================================
// Session Filter
//====================================================
input group "Session"

input bool EnableLondon = true;
input bool EnableNewYork = true;

input int LondonOpen = 8;
input int LondonClose = 17;

input int NewYorkOpen = 13;
input int NewYorkClose = 22;

//====================================================
// Risk
//====================================================
input group "Risk"

input bool UseBreakEven = true;
input int BreakEvenPoints = 300;

input bool UseTrailing = true;
input int TrailingStop = 250;

input double MaxSpread = 30;

//====================================================
// Smart Money Concept
//====================================================
input group "SMC"

input int SwingLength = 5;

input int LiquidityLookBack = 50;

input int StopBuffer = 150;

//====================================================
// Dashboard
//====================================================
input group "Dashboard"

input bool ShowDashboard = true;

#endif

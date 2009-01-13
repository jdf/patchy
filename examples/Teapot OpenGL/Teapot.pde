import processing.opengl.*;

import peasy.*;
import patchy.*;

// The Utah teapot!
PVector[][][] teapot = new PVector[][][] {
  {
    {
      new PVector(-80.0,0.0,30.0),
      new PVector(-80.0,-44.8,30.0),
      new PVector(-44.8,-80.0,30.0),
      new PVector(0.0,-80.0,30.0),
    }
    ,
    {
      new PVector(-80.0,0.0,12.0),
      new PVector(-80.0,-44.8,12.0),
      new PVector(-44.8,-80.0,12.0),
      new PVector(0.0,-80.0,12.0),
    }
    ,
    {
      new PVector(-60.0,0.0,3.0),
      new PVector(-60.0,-33.6,3.0),
      new PVector(-33.6,-60.0,3.0),
      new PVector(0.0,-60.0,3.0),
    }
    ,
    {
      new PVector(-60.0,0.0,0.0),
      new PVector(-60.0,-33.6,0.0),
      new PVector(-33.6,-60.0,0.0),
      new PVector(0.0,-60.0,0.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,-80.0,30.0),
      new PVector(44.8,-80.0,30.0),
      new PVector(80.0,-44.8,30.0),
      new PVector(80.0,0.0,30.0),
    }
    ,
    {
      new PVector(0.0,-80.0,12.0),
      new PVector(44.8,-80.0,12.0),
      new PVector(80.0,-44.8,12.0),
      new PVector(80.0,0.0,12.0),
    }
    ,
    {
      new PVector(0.0,-60.0,3.0),
      new PVector(33.6,-60.0,3.0),
      new PVector(60.0,-33.6,3.0),
      new PVector(60.0,0.0,3.0),
    }
    ,
    {
      new PVector(0.0,-60.0,0.0),
      new PVector(33.6,-60.0,0.0),
      new PVector(60.0,-33.6,0.0),
      new PVector(60.0,0.0,0.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-60.0,0.0,90.0),
      new PVector(-60.0,-33.6,90.0),
      new PVector(-33.6,-60.0,90.0),
      new PVector(0.0,-60.0,90.0),
    }
    ,
    {
      new PVector(-70.0,0.0,69.0),
      new PVector(-70.0,-39.20,69.0),
      new PVector(-39.20,-70.0,69.0),
      new PVector(0.0,-70.0,69.0),
    }
    ,
    {
      new PVector(-80.0,0.0,48.0),
      new PVector(-80.0,-44.8,48.0),
      new PVector(-44.8,-80.0,48.0),
      new PVector(0.0,-80.0,48.0),
    }
    ,
    {
      new PVector(-80.0,0.0,30.0),
      new PVector(-80.0,-44.8,30.0),
      new PVector(-44.8,-80.0,30.0),
      new PVector(0.0,-80.0,30.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,-60.0,90.0),
      new PVector(33.6,-60.0,90.0),
      new PVector(60.0,-33.6,90.0),
      new PVector(60.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,-70.0,69.0),
      new PVector(39.20,-70.0,69.0),
      new PVector(70.0,-39.20,69.0),
      new PVector(70.0,0.0,69.0),
    }
    ,
    {
      new PVector(0.0,-80.0,48.0),
      new PVector(44.8,-80.0,48.0),
      new PVector(80.0,-44.8,48.0),
      new PVector(80.0,0.0,48.0),
    }
    ,
    {
      new PVector(0.0,-80.0,30.0),
      new PVector(44.8,-80.0,30.0),
      new PVector(80.0,-44.8,30.0),
      new PVector(80.0,0.0,30.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-56.0,0.0,90.0),
      new PVector(-56.0,-31.36,90.0),
      new PVector(-31.36,-56.0,90.0),
      new PVector(0.0,-56.0,90.0),
    }
    ,
    {
      new PVector(-53.5,0.0,95.25),
      new PVector(-53.5,-29.96,95.25),
      new PVector(-29.96,-53.5,95.25),
      new PVector(0.0,-53.5,95.25),
    }
    ,
    {
      new PVector(-57.5,0.0,95.25),
      new PVector(-57.5,-32.20,95.25),
      new PVector(-32.20,-57.5,95.25),
      new PVector(0.0,-57.5,95.25),
    }
    ,
    {
      new PVector(-60.0,0.0,90.0),
      new PVector(-60.0,-33.6,90.0),
      new PVector(-33.6,-60.0,90.0),
      new PVector(0.0,-60.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,-56.0,90.0),
      new PVector(31.36,-56.0,90.0),
      new PVector(56.0,-31.36,90.0),
      new PVector(56.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,-53.5,95.25),
      new PVector(29.96,-53.5,95.25),
      new PVector(53.5,-29.96,95.25),
      new PVector(53.5,0.0,95.25),
    }
    ,
    {
      new PVector(0.0,-57.5,95.25),
      new PVector(32.20,-57.5,95.25),
      new PVector(57.5,-32.20,95.25),
      new PVector(57.5,0.0,95.25),
    }
    ,
    {
      new PVector(0.0,-60.0,90.0),
      new PVector(33.6,-60.0,90.0),
      new PVector(60.0,-33.6,90.0),
      new PVector(60.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(80.0,0.0,30.0),
      new PVector(80.0,44.80,30.0),
      new PVector(44.80,80.0,30.0),
      new PVector(0.0,80.0,30.0),
    }
    ,
    {
      new PVector(80.0,0.0,12.0),
      new PVector(80.0,44.80,12.0),
      new PVector(44.80,80.0,12.0),
      new PVector(0.0,80.0,12.0),
    }
    ,
    {
      new PVector(60.0,0.0,3.0),
      new PVector(60.0,33.60,3.0),
      new PVector(33.60,60.0,3.0),
      new PVector(0.0,60.0,3.0),
    }
    ,
    {
      new PVector(60.0,0.0,0.0),
      new PVector(60.0,33.60,0.0),
      new PVector(33.60,60.0,0.0),
      new PVector(0.0,60.0,0.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,80.0,30.0),
      new PVector(-44.80,80.0,30.0),
      new PVector(-80.0,44.80,30.0),
      new PVector(-80.0,0.0,30.0),
    }
    ,
    {
      new PVector(0.0,80.0,12.0),
      new PVector(-44.80,80.0,12.0),
      new PVector(-80.0,44.80,12.0),
      new PVector(-80.0,0.0,12.0),
    }
    ,
    {
      new PVector(0.0,60.0,3.0),
      new PVector(-33.60,60.0,3.0),
      new PVector(-60.0,33.60,3.0),
      new PVector(-60.0,0.0,3.0),
    }
    ,
    {
      new PVector(0.0,60.0,0.0),
      new PVector(-33.60,60.0,0.0),
      new PVector(-60.0,33.60,0.0),
      new PVector(-60.0,0.0,0.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(60.0,0.0,90.0),
      new PVector(60.0,33.60,90.0),
      new PVector(33.60,60.0,90.0),
      new PVector(0.0,60.0,90.0),
    }
    ,
    {
      new PVector(70.0,0.0,69.0),
      new PVector(70.0,39.20,69.0),
      new PVector(39.20,70.0,69.0),
      new PVector(0.0,70.0,69.0),
    }
    ,
    {
      new PVector(80.0,0.0,48.0),
      new PVector(80.0,44.80,48.0),
      new PVector(44.80,80.0,48.0),
      new PVector(0.0,80.0,48.0),
    }
    ,
    {
      new PVector(80.0,0.0,30.0),
      new PVector(80.0,44.80,30.0),
      new PVector(44.80,80.0,30.0),
      new PVector(0.0,80.0,30.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,60.0,90.0),
      new PVector(-33.60,60.0,90.0),
      new PVector(-60.0,33.60,90.0),
      new PVector(-60.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,70.0,69.0),
      new PVector(-39.20,70.0,69.0),
      new PVector(-70.0,39.20,69.0),
      new PVector(-70.0,0.0,69.0),
    }
    ,
    {
      new PVector(0.0,80.0,48.0),
      new PVector(-44.80,80.0,48.0),
      new PVector(-80.0,44.80,48.0),
      new PVector(-80.0,0.0,48.0),
    }
    ,
    {
      new PVector(0.0,80.0,30.0),
      new PVector(-44.80,80.0,30.0),
      new PVector(-80.0,44.80,30.0),
      new PVector(-80.0,0.0,30.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(56.0,0.0,90.0),
      new PVector(56.0,31.36,90.0),
      new PVector(31.36,56.0,90.0),
      new PVector(0.0,56.0,90.0),
    }
    ,
    {
      new PVector(53.50,0.0,95.25),
      new PVector(53.50,29.96,95.25),
      new PVector(29.96,53.50,95.25),
      new PVector(0.0,53.50,95.25),
    }
    ,
    {
      new PVector(57.50,0.0,95.25),
      new PVector(57.50,32.20,95.25),
      new PVector(32.20,57.50,95.25),
      new PVector(0.0,57.50,95.25),
    }
    ,
    {
      new PVector(60.0,0.0,90.0),
      new PVector(60.0,33.60,90.0),
      new PVector(33.60,60.0,90.0),
      new PVector(0.0,60.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,56.0,90.0),
      new PVector(-31.36,56.0,90.0),
      new PVector(-56.0,31.36,90.0),
      new PVector(-56.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,53.50,95.25),
      new PVector(-29.96,53.50,95.25),
      new PVector(-53.50,29.96,95.25),
      new PVector(-53.50,0.0,95.25),
    }
    ,
    {
      new PVector(0.0,57.50,95.25),
      new PVector(-32.20,57.50,95.25),
      new PVector(-57.50,32.20,95.25),
      new PVector(-57.50,0.0,95.25),
    }
    ,
    {
      new PVector(0.0,60.0,90.0),
      new PVector(-33.60,60.0,90.0),
      new PVector(-60.0,33.60,90.0),
      new PVector(-60.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(68.0,0.0,51.0),
      new PVector(68.0,26.40,51.0),
      new PVector(68.0,26.40,18.0),
      new PVector(68.0,0.0,18.0),
    }
    ,
    {
      new PVector(104.0,0.0,51.0),
      new PVector(104.0,26.40,51.0),
      new PVector(124.0,26.40,27.0),
      new PVector(124.0,0.0,27.0),
    }
    ,
    {
      new PVector(92.0,0.0,78.0),
      new PVector(92.0,10.0,78.0),
      new PVector(96.0,10.0,75.0),
      new PVector(96.0,0.0,75.0),
    }
    ,
    {
      new PVector(108.0,0.0,90.0),
      new PVector(108.0,10.0,90.0),
      new PVector(132.0,10.0,90.0),
      new PVector(132.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(68.0,0.0,18.0),
      new PVector(68.0,-26.40,18.0),
      new PVector(68.0,-26.40,51.0),
      new PVector(68.0,0.0,51.0),
    }
    ,
    {
      new PVector(124.0,0.0,27.0),
      new PVector(124.0,-26.40,27.0),
      new PVector(104.0,-26.40,51.0),
      new PVector(104.0,0.0,51.0),
    }
    ,
    {
      new PVector(96.0,0.0,75.0),
      new PVector(96.0,-10.0,75.0),
      new PVector(92.0,-10.0,78.0),
      new PVector(92.0,0.0,78.0),
    }
    ,
    {
      new PVector(132.0,0.0,90.0),
      new PVector(132.0,-10.0,90.0),
      new PVector(108.0,-10.0,90.0),
      new PVector(108.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(108.0,0.0,90.0),
      new PVector(108.0,10.0,90.0),
      new PVector(132.0,10.0,90.0),
      new PVector(132.0,0.0,90.0),
    }
    ,
    {
      new PVector(112.0,0.0,93.0),
      new PVector(112.0,10.0,93.0),
      new PVector(141.0,10.0,93.75),
      new PVector(141.0,0.0,93.75),
    }
    ,
    {
      new PVector(116.0,0.0,93.0),
      new PVector(116.0,6.0,93.0),
      new PVector(138.0,6.0,94.50),
      new PVector(138.0,0.0,94.50),
    }
    ,
    {
      new PVector(112.0,0.0,90.0),
      new PVector(112.0,6.0,90.0),
      new PVector(128.0,6.0,90.0),
      new PVector(128.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(132.0,0.0,90.0),
      new PVector(132.0,-10.0,90.0),
      new PVector(108.0,-10.0,90.0),
      new PVector(108.0,0.0,90.0),
    }
    ,
    {
      new PVector(141.0,0.0,93.75),
      new PVector(141.0,-10.0,93.75),
      new PVector(112.0,-10.0,93.0),
      new PVector(112.0,0.0,93.0),
    }
    ,
    {
      new PVector(138.0,0.0,94.50),
      new PVector(138.0,-6.0,94.50),
      new PVector(116.0,-6.0,93.0),
      new PVector(116.0,0.0,93.0),
    }
    ,
    {
      new PVector(128.0,0.0,90.0),
      new PVector(128.0,-6.0,90.0),
      new PVector(112.0,-6.0,90.0),
      new PVector(112.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-64.0,0.0,75.0),
      new PVector(-64.0,12.0,75.0),
      new PVector(-60.0,12.0,84.0),
      new PVector(-60.0,0.0,84.0),
    }
    ,
    {
      new PVector(-92.0,0.0,75.0),
      new PVector(-92.0,12.0,75.0),
      new PVector(-100.0,12.0,84.0),
      new PVector(-100.0,0.0,84.0),
    }
    ,
    {
      new PVector(-108.0,0.0,75.0),
      new PVector(-108.0,12.0,75.0),
      new PVector(-120.0,12.0,84.0),
      new PVector(-120.0,0.0,84.0),
    }
    ,
    {
      new PVector(-108.0,0.0,66.0),
      new PVector(-108.0,12.0,66.0),
      new PVector(-120.0,12.0,66.0),
      new PVector(-120.0,0.0,66.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-60.0,0.0,84.0),
      new PVector(-60.0,-12.0,84.0),
      new PVector(-64.0,-12.0,75.0),
      new PVector(-64.0,0.0,75.0),
    }
    ,
    {
      new PVector(-100.0,0.0,84.0),
      new PVector(-100.0,-12.0,84.0),
      new PVector(-92.0,-12.0,75.0),
      new PVector(-92.0,0.0,75.0),
    }
    ,
    {
      new PVector(-120.0,0.0,84.0),
      new PVector(-120.0,-12.0,84.0),
      new PVector(-108.0,-12.0,75.0),
      new PVector(-108.0,0.0,75.0),
    }
    ,
    {
      new PVector(-120.0,0.0,66.0),
      new PVector(-120.0,-12.0,66.0),
      new PVector(-108.0,-12.0,66.0),
      new PVector(-108.0,0.0,66.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-108.0,0.0,66.0),
      new PVector(-108.0,12.0,66.0),
      new PVector(-120.0,12.0,66.0),
      new PVector(-120.0,0.0,66.0),
    }
    ,
    {
      new PVector(-108.0,0.0,57.0),
      new PVector(-108.0,12.0,57.0),
      new PVector(-120.0,12.0,48.0),
      new PVector(-120.0,0.0,48.0),
    }
    ,
    {
      new PVector(-100.0,0.0,39.0),
      new PVector(-100.0,12.0,39.0),
      new PVector(-106.0,12.0,31.50),
      new PVector(-106.0,0.0,31.50),
    }
    ,
    {
      new PVector(-80.0,0.0,30.0),
      new PVector(-80.0,12.0,30.0),
      new PVector(-76.0,12.0,18.0),
      new PVector(-76.0,0.0,18.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-120.0,0.0,66.0),
      new PVector(-120.0,-12.0,66.0),
      new PVector(-108.0,-12.0,66.0),
      new PVector(-108.0,0.0,66.0),
    }
    ,
    {
      new PVector(-120.0,0.0,48.0),
      new PVector(-120.0,-12.0,48.0),
      new PVector(-108.0,-12.0,57.0),
      new PVector(-108.0,0.0,57.0),
    }
    ,
    {
      new PVector(-106.0,0.0,31.50),
      new PVector(-106.0,-12.0,31.50),
      new PVector(-100.0,-12.0,39.0),
      new PVector(-100.0,0.0,39.0),
    }
    ,
    {
      new PVector(-76.0,0.0,18.0),
      new PVector(-76.0,-12.0,18.0),
      new PVector(-80.0,-12.0,30.0),
      new PVector(-80.0,0.0,30.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(8.0,0.0,102.0),
      new PVector(8.0,4.48,102.0),
      new PVector(4.48,8.0,102.0),
      new PVector(0.0,8.0,102.0),
    }
    ,
    {
      new PVector(16.0,0.0,96.0),
      new PVector(16.0,8.96,96.0),
      new PVector(8.96,16.0,96.0),
      new PVector(0.0,16.0,96.0),
    }
    ,
    {
      new PVector(52.0,0.0,96.0),
      new PVector(52.0,29.12,96.0),
      new PVector(29.12,52.0,96.0),
      new PVector(0.0,52.0,96.0),
    }
    ,
    {
      new PVector(52.0,0.0,90.0),
      new PVector(52.0,29.12,90.0),
      new PVector(29.12,52.0,90.0),
      new PVector(0.0,52.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,8.0,102.0),
      new PVector(-4.48,8.0,102.0),
      new PVector(-8.0,4.48,102.0),
      new PVector(-8.0,0.0,102.0),
    }
    ,
    {
      new PVector(0.0,16.0,96.0),
      new PVector(-8.96,16.0,96.0),
      new PVector(-16.0,8.96,96.0),
      new PVector(-16.0,0.0,96.0),
    }
    ,
    {
      new PVector(0.0,52.0,96.0),
      new PVector(-29.12,52.0,96.0),
      new PVector(-52.0,29.12,96.0),
      new PVector(-52.0,0.0,96.0),
    }
    ,
    {
      new PVector(0.0,52.0,90.0),
      new PVector(-29.12,52.0,90.0),
      new PVector(-52.0,29.12,90.0),
      new PVector(-52.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-8.0,0.0,102.0),
      new PVector(-8.0,-4.48,102.0),
      new PVector(-4.48,-8.0,102.0),
      new PVector(0.0,-8.0,102.0),
    }
    ,
    {
      new PVector(-16.0,0.0,96.0),
      new PVector(-16.0,-8.96,96.0),
      new PVector(-8.96,-16.0,96.0),
      new PVector(0.0,-16.0,96.0),
    }
    ,
    {
      new PVector(-52.0,0.0,96.0),
      new PVector(-52.0,-29.12,96.0),
      new PVector(-29.12,-52.0,96.0),
      new PVector(0.0,-52.0,96.0),
    }
    ,
    {
      new PVector(-52.0,0.0,90.0),
      new PVector(-52.0,-29.12,90.0),
      new PVector(-29.12,-52.0,90.0),
      new PVector(0.0,-52.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,-8.0,102.0),
      new PVector(4.48,-8.0,102.0),
      new PVector(8.0,-4.48,102.0),
      new PVector(8.0,0.0,102.0),
    }
    ,
    {
      new PVector(0.0,-16.0,96.0),
      new PVector(8.96,-16.0,96.0),
      new PVector(16.0,-8.96,96.0),
      new PVector(16.0,0.0,96.0),
    }
    ,
    {
      new PVector(0.0,-52.0,96.0),
      new PVector(29.12,-52.0,96.0),
      new PVector(52.0,-29.12,96.0),
      new PVector(52.0,0.0,96.0),
    }
    ,
    {
      new PVector(0.0,-52.0,90.0),
      new PVector(29.12,-52.0,90.0),
      new PVector(52.0,-29.12,90.0),
      new PVector(52.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
    }
    ,
    {
      new PVector(32.0,0.0,120.0),
      new PVector(32.0,18.0,120.0),
      new PVector(18.0,32.0,120.0),
      new PVector(0.0,32.0,120.0),
    }
    ,
    {
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
    }
    ,
    {
      new PVector(8.0,0.0,102.0),
      new PVector(8.0,4.48,102.0),
      new PVector(4.48,8.0,102.0),
      new PVector(0.0,8.0,102.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
    }
    ,
    {
      new PVector(0.0,32.0,120.0),
      new PVector(-18.0,32.0,120.0),
      new PVector(-32.0,18.0,120.0),
      new PVector(-32.0,0.0,120.0),
    }
    ,
    {
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
    }
    ,
    {
      new PVector(0.0,8.0,102.0),
      new PVector(-4.48,8.0,102.0),
      new PVector(-8.0,4.48,102.0),
      new PVector(-8.0,0.0,102.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
    }
    ,
    {
      new PVector(-32.0,0.0,120.0),
      new PVector(-32.0,-18.0,120.0),
      new PVector(-18.0,-32.0,120.0),
      new PVector(0.0,-32.0,120.0),
    }
    ,
    {
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
    }
    ,
    {
      new PVector(-8.0,0.0,102.0),
      new PVector(-8.0,-4.48,102.0),
      new PVector(-4.48,-8.0,102.0),
      new PVector(0.0,-8.0,102.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
      new PVector(0.0,0.0,120.0),
    }
    ,
    {
      new PVector(0.0,-32.0,120.0),
      new PVector(18.0,-32.0,120.0),
      new PVector(32.0,-18.0,120.0),
      new PVector(32.0,0.0,120.0),
    }
    ,
    {
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
      new PVector(0.0,0.0,108.0),
    }
    ,
    {
      new PVector(0.0,-8.0,102.0),
      new PVector(4.48,-8.0,102.0),
      new PVector(8.0,-4.48,102.0),
      new PVector(8.0,0.0,102.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(50.0,0.0,90.0),
      new PVector(50.0,28.0,90.0),
      new PVector(28.0,50.0,90.0),
      new PVector(0.0,50.0,90.0),
    }
    ,
    {
      new PVector(52.0,0.0,90.0),
      new PVector(52.0,29.12,90.0),
      new PVector(29.12,52.0,90.0),
      new PVector(0.0,52.0,90.0),
    }
    ,
    {
      new PVector(54.0,0.0,90.0),
      new PVector(54.0,30.24,90.0),
      new PVector(30.24,54.0,90.0),
      new PVector(0.0,54.0,90.0),
    }
    ,
    {
      new PVector(56.0,0.0,90.0),
      new PVector(56.0,31.36,90.0),
      new PVector(31.36,56.0,90.0),
      new PVector(0.0,56.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,50.0,90.0),
      new PVector(-28.0,50.0,90.0),
      new PVector(-50.0,28.0,90.0),
      new PVector(-50.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,52.0,90.0),
      new PVector(-29.12,52.0,90.0),
      new PVector(-52.0,29.12,90.0),
      new PVector(-52.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,54.0,90.0),
      new PVector(-30.24,54.0,90.0),
      new PVector(-54.0,30.24,90.0),
      new PVector(-54.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,56.0,90.0),
      new PVector(-31.36,56.0,90.0),
      new PVector(-56.0,31.36,90.0),
      new PVector(-56.0,0.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(-50.0,0.0,90.0),
      new PVector(-50.0,-28.0,90.0),
      new PVector(-28.0,-50.0,90.0),
      new PVector(0.0,-50.0,90.0),
    }
    ,
    {
      new PVector(-52.0,0.0,90.0),
      new PVector(-52.0,-29.12,90.0),
      new PVector(-29.12,-52.0,90.0),
      new PVector(0.0,-52.0,90.0),
    }
    ,
    {
      new PVector(-54.0,0.0,90.0),
      new PVector(-54.0,-30.24,90.0),
      new PVector(-30.24,-54.0,90.0),
      new PVector(0.0,-54.0,90.0),
    }
    ,
    {
      new PVector(-56.0,0.0,90.0),
      new PVector(-56.0,-31.36,90.0),
      new PVector(-31.36,-56.0,90.0),
      new PVector(0.0,-56.0,90.0),
    }
    ,
  }
  ,
  {
    {
      new PVector(0.0,-50.0,90.0),
      new PVector(28.0,-50.0,90.0),
      new PVector(50.0,-28.0,90.0),
      new PVector(50.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,-52.0,90.0),
      new PVector(29.12,-52.0,90.0),
      new PVector(52.0,-29.12,90.0),
      new PVector(52.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,-54.0,90.0),
      new PVector(30.24,-54.0,90.0),
      new PVector(54.0,-30.24,90.0),
      new PVector(54.0,0.0,90.0),
    }
    ,
    {
      new PVector(0.0,-56.0,90.0),
      new PVector(31.36,-56.0,90.0),
      new PVector(56.0,-31.36,90.0),
      new PVector(56.0,0.0,90.0),
    }
    ,
  }
};

Patch[] patches;
BoundingVolume bounds;
void setup() {
  size(600,600,OPENGL);
  patches = new Patch[teapot.length];
  bounds = new BoundingVolume();
  for (int i = 0; i < teapot.length; i++) {
    patches[i] = Patch.create(Patch.BEZIER, teapot[i], 15);
    bounds = bounds.with(patches[i].getBounds());
  }
  new PeasyCam(this, bounds.x.center(), bounds.y.center(), bounds.z.center(),300);
}
void draw() {
  translate(bounds.x.center(), bounds.y.center(), bounds.z.center());
  rotateX(PI/3);
  translate(-bounds.x.center(), -bounds.y.center(), -bounds.z.center());
  background(0);
  lights();
  pointLight(100,100,255,100,-100, 200);
  pointLight(255,100,100,100,100, 200);
  pointLight(100,255,100,-100,100, 200);
  noStroke();
  fill(160, 160, 160);
  for (int i = 0; i < patches.length; i++)
    patches[i].draw(this);
  translate(0,0,bounds.z.minimum());
  ellipseMode(CENTER);
  ellipse(0,0,121,121);
}




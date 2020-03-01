var data = [{
  r: [50, 120, 11, 359, 828, 788, 503, 844, 1725, 2761, 2120, 1205],
  theta: ["April 1854", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March 1855"],  
  text: ["April 1854", "May 1854", "June 1854", "July 1854", "August 1854", "September 1854", "October 1854", "November 1854", "December 1854", "January 1855", "February 1855", "March 1855"],
  hovertemplate:"Deaths: %{r}<br>Month: %{text}<extra></extra>",
  name: "Zymotic diseases",
  marker: {color: "rgb(106,81,163)", line:{width:1, color:"rgb(80,80,80)"}},
  type: "barpolar"
}, {
  r: [150, 220, 350, 287, 500, 95, 132, 287, 570, 850, 420, 320],
  theta: ["April 1854", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March 1855"],
  text: ["April 1854", "May 1854", "June 1854", "July 1854", "August 1854", "September 1854", "October 1854", "November 1854", "December 1854", "January 1855", "February 1855", "March 1855"],
  hovertemplate:"Deaths: %{r}<br>Month: %{text}<extra></extra>",
  name: "Wounds & injuries",
  marker: {color: "rgb(220,30,20)", line:{width:1, color:"rgb(80,80,80)"}},
  type: "barpolar"
}, {
  r: [50, 250, 6, 23, 30, 70, 128, 106, 131, 324, 361, 172],
  theta: ["April 1854", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February", "March 1855"],
  text: ["April 1854", "May 1854", "June 1854", "July 1854", "August 1854", "September 1854", "October 1854", "November 1854", "December 1854", "January 1855", "February 1855", "March 1855"],
  hovertemplate:"Deaths: %{r}<br>Month: %{text}<extra></extra>",
  name: "All other causes",
  marker: {color: "rgb(35,180,84)", line:{width:1, color:"rgb(80,80,80)"}},
  type: "barpolar"
}]
var layoutClockwise = {
  font: {size: 12}, 
  showlegend: false,
  width:500,
  height:500,
  autosize:true,
  polar: {
    bgcolor:"#e2f1f7",
    barmode: "overlay",
    bargap: 0,
    radialaxis: {visible: false},
    angularaxis: {direction: "clockwise", showline: false, showgrid: false, rotation:165}
  }
}

var layoutAnticlockwise = {
  font: {size: 15},
  width:900,
  height:900,
  autosize:true,
  polar: {
    bgcolor:"#e2f1f7",
    barmode: "overlay",
    bargap: 0,
    radialaxis: {visible: false},
    angularaxis: {direction: "anticlockwise", showline: false, showgrid: false, rotation:195}
  }
}

Plotly.newPlot("originalPlot", data, layoutClockwise)
Plotly.newPlot("rotatedPlot", data, layoutAnticlockwise)
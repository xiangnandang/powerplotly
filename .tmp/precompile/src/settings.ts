/*
 *  Power BI Visualizations
 *
 *  Copyright (c) Microsoft Corporation
 *  All rights reserved.
 *  MIT License
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the ""Software""), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

module powerbi.extensibility.visual.pBIplotlyAFEA9760BDCA4473BEA802445EC7558B  {
  "use strict";

  import DataViewObjectsParser = powerbi.extensibility.utils.dataview.DataViewObjectsParser;

  export class VisualSettings extends DataViewObjectsParser {
    public rcv_script: rcv_scriptSettings = new rcv_scriptSettings();
    public settings_saving_params: settings_saving_params = new settings_saving_params();
    public settings_fitting_params: settings_fitting_params = new settings_fitting_params();
    public settings_scatter_params: settings_scatter_params = new settings_scatter_params();
    public settings_xaxis_params: settings_xaxis_params = new settings_xaxis_params();
    public settings_yaxis_params: settings_yaxis_params = new settings_yaxis_params();
    public settings_legend_params: settings_legend_params = new settings_legend_params();
    public settings_facetgrid_params: settings_facetgrid_params = new settings_facetgrid_params();
    public settings_title_params: settings_title_params = new settings_title_params();
    public settings_theme_params: settings_theme_params = new settings_theme_params();
  }

  export class rcv_scriptSettings {
    // undefined
    public provider     // undefined
    public source
  }

  export class settings_saving_params {
    public show: boolean = false;
  }

  export class settings_fitting_params {
    public show: boolean = true;
    public equation: boolean = true;
    public equationsize: number = 3;
    public equationx: number = 0.75;
    public equationy: number = 1;
    public lineWidth: number = 1;
    public se: boolean = true;
    public level: string = "0.95";
  }

  export class settings_scatter_params {
    public size: number = 1;
    public color: string = "orange";
    public opacity: number = 100;
  }

  export class settings_xaxis_params {
    public factor: boolean = false;
    public xstart: number = null;
    public xend: number = null;
    public xtitle: string = "";
    public xtitlesize: number = null;
    public xtextsize: number = null;
  }

  export class settings_yaxis_params {
    public factor: boolean = false;
    public ystart: number = null;
    public yend: number = null;
    public ytitle: string = "";
    public ytitlesize: number = null;
    public ytextsize: number = null;
  }

  export class settings_legend_params {
    public factor: boolean = true;
    public colortitle: string = "";
    public colortitlesize: number = null;
    public colortextsize: number = null;
  }

  export class settings_facetgrid_params {
    public scales: string = "fixed";
    public space: string = "fixed";
    public labeller: string = "label_both";
    public horizontaltextsize: number = null;
    public verticaltextsize: number = null;
  }

  export class settings_title_params {
    public title: string = "";
    public fontsize: number = null;
  }

  export class settings_theme_params {
    public theme: string = "gray";
  }
}

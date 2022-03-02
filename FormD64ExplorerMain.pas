//------------------------------------------------------------------------------
//FormD64ExplorerMain
//===================
//Application Main Form.  The application functions are managed and performed by
//the Main Data Module.
//
//Copyright (C) 2016, Daniel England.
//All Rights Reserved.  Released under the GPL.
//
//This program is free software: you can redistribute it and/or modify it under
//the terms of the GNU General Public License as published by the Free Software
//Foundation, either version 3 of the License, or (at your option) any later
//version.
//
//This program is distributed in the hope that it will be useful, but WITHOUT
//ANY WARRANTY; without even  the implied warranty of MERCHANTABILITY or FITNESS
//FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
//details.
//
//You should have received a copy of the GNU General Public License along with
//this program.  If not, see <http://www.gnu.org/licenses/>.
//
//------------------------------------------------------------------------------
unit FormD64ExplorerMain;

{$mode delphi}{$H+}

interface

uses
 	Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
    ActnList, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type

{ TD64ExplorerMainForm }

   TD64ExplorerMainForm = class(TForm)
		Bevel1: TBevel;
		Bevel2: TBevel;
		Bevel3: TBevel;
		CoolBar1: TCoolBar;
        CoolBar2: TCoolBar;
		CoolBar3: TCoolBar;
        Label1: TLabel;
        PaintBox1: TPaintBox;
        Panel1: TPanel;
		Panel2: TPanel;
        Panel3: TPanel;
        Panel4: TPanel;
		Panel5: TPanel;
		Panel6: TPanel;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
		SpeedButton3: TSpeedButton;
		SpeedButton4: TSpeedButton;
		SpeedButton5: TSpeedButton;
		SpeedButton6: TSpeedButton;
        SpeedButton7: TSpeedButton;
		SpeedButton8: TSpeedButton;
		procedure CoolBar3Resize(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
		procedure FormCreate(Sender: TObject);
        procedure FormDropFiles(Sender: TObject;
            const FileNames: array of String);
		procedure FormResize(Sender: TObject);
        procedure PaintBox1Paint(Sender: TObject);
		procedure Panel5Paint(Sender: TObject);
        procedure SpeedButton1Paint(Sender: TObject);
  	private
    	FBarBmp: TBitmap;
    public
    	{ public declarations }
  	end;

var
  	D64ExplorerMainForm: TD64ExplorerMainForm;

implementation

{$R *.lfm}

uses
    GraphType, DModD64ExplorerMain;

{ TD64ExplorerMainForm }


procedure TD64ExplorerMainForm.FormClose(Sender: TObject;
        var CloseAction: TCloseAction);
    begin
    D64ExplorerMainDMod.ApplicationClose;
    end;

procedure TD64ExplorerMainForm.CoolBar3Resize(Sender: TObject);
	begin
    if  not Application.Terminated then
		D64ExplorerMainDMod.RezizeFilesBar;
	end;

procedure TD64ExplorerMainForm.FormCloseQuery(Sender: TObject;
    	var CanClose: Boolean);
	begin
    D64ExplorerMainDMod.CloseQuery(CanClose);
	end;

procedure TD64ExplorerMainForm.FormCreate(Sender: TObject);
	begin
    FBarBmp:= TBitmap.Create;
	end;

procedure TD64ExplorerMainForm.FormDropFiles(Sender: TObject;
    	const FileNames: array of String);
	begin
    D64ExplorerMainDMod.AddDropFiles(FileNames);
	end;

procedure TD64ExplorerMainForm.FormResize(Sender: TObject);
	begin
    Panel5.Height:= ClientHeight - (CoolBar1.GrabWidth + 52 * 3 + 4);

	FBarBmp.Width:= ClientWidth;
	FBarBmp.Height:= 16;
    FBarBmp.Canvas.GradientFill(Coolbar3.ClientRect, clMenuBar,
			clBackground, gdHorizontal);
	CoolBar1.Bitmap:= FBarBmp;

	CoolBar3.Bitmap:= FBarBmp;
	end;

procedure TD64ExplorerMainForm.PaintBox1Paint(Sender: TObject);
	begin
    PaintBox1.Canvas.GradientFill(PaintBox1.ClientRect, clInactiveCaption,
			clBackground,gdHorizontal);
	end;

procedure TD64ExplorerMainForm.Panel5Paint(Sender: TObject);
	begin
    Panel5.Canvas.GradientFill(Panel5.ClientRect, clInactiveCaption,
			clBackground, gdVertical);
	end;

procedure TD64ExplorerMainForm.SpeedButton1Paint(Sender: TObject);
    var
	pt: TPoint;
    sb: TSpeedButton;
	de: TGraphicsDrawEffect;

    begin
    sb:= Sender as TSpeedButton;

    if  sb.Down then
    	begin
        if  sb.Enabled then
        	sb.Canvas.Brush.Color:= clMenuBar
        else
            sb.Canvas.Brush.Color:= clInactiveCaption;

		sb.Canvas.Brush.Style:= bsSolid;
		sb.Canvas.GradientFill(sb.ClientRect, clMenuHighlight,
				sb.Canvas.Brush.Color, gdVertical);

		pt.x:= 4;
		pt.y:= 4;

        end
	else
		begin
        if  sb.MouseInClient then
        	sb.Canvas.Brush.Color:= clMenuHighlight
		else
        	sb.Canvas.Brush.Color:= clInactiveCaption;
//        else
//            sb.Canvas.Brush.Color:= clBtnShadow;

		sb.Canvas.Brush.Style:= bsSolid;
		sb.Canvas.FillRect(sb.ClientRect);

			pt.x:= 2;
			pt.y:= 2;
		end;

	if  not sb.Enabled then
		begin
		de:= gdeDisabled;
		end
	else
//		if sb.MouseInClient
//		and not sb.Down then
//			de:= gdeHighlighted
//		else
			de:= gdeNormal;

	sb.Images.Draw(sb.Canvas, pt.X, pt.Y, sb.ImageIndex, de);
    end;


end.


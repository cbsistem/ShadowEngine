unit uEngine2DSprite;

interface

uses
  System.Types, FMX.Graphics, FMX.Objects, FMX.Types,
  uEngine2DClasses, uEngine2DObject, uEngine2DResources,
  uEngine2DUnclickableObject;

type

  TSprite = class(tEngine2DObject)
  private
    fResources: TEngine2DResources;
    fWhalf, fHHalf: single; // �������� ������ � ������
    fCurRes: Integer;
    function getScW: single;
    function getScH: single;
  protected
    function GetW: single; override;
    function GetH: single; override;
    procedure SetCurRes(const Value: Integer); virtual;
  public
    property Resources: TEngine2DResources read FResources write FResources;
    property CurRes: Integer read fCurRes write SetCurRes;
    property wHalf: single read fWhalf; // ��������� �������� - �������� ������
    property hHalf: single read fHHalf; // ��������� �������� - �������� ������
    property scW: single read getScW; // ��� ������ � ������ ��������
    property scH: single read getScH; // ��� ������ � ������ ��������

    function UnderTheMouse(const MouseX, MouseY: Double): boolean; override;
    procedure Repaint; override;

    constructor Create(AParent: pointer); override;
    destructor Destroy; override;
  end;


implementation

uses
  uEngine2D, mainUnit;

{ tSprite }

constructor tSprite.Create(AParent: pointer);
begin
  inherited Create(AParent);
  fCreationNumber := tEngine2d(fParent).spriteCount;
end;

destructor tSprite.Destroy;
begin
  inherited;
end;

function tSprite.getScH: single;
begin
  result := h * fPosition.scaleY;
end;

function tSprite.getScW: single;
begin
  result := w * fPosition.scaleX;
end;

function tSprite.getH: single;
begin
  Result := self.Resources[fCurRes].bmp.Height;
end;

function tSprite.getW: single;
begin
  Result := self.Resources[fCurRes].bmp.Width;
end;

procedure tSprite.Repaint;
begin
  Image.Bitmap.Canvas.DrawBitmap(
    fResources[fCurRes].bmp,
    fResources[fCurRes].rect,
              RectF(x + wHalf * CJustifyPoints[Justify].Left,
              y + hHalf * CJustifyPoints[Justify].Top,
              x + wHalf * CJustifyPoints[Justify].Right,
              y + hHalf * CJustifyPoints[Justify].Bottom),
              Opacity, False
            );

  if DrawSelect then
    Shape.Draw;
end;

procedure tSprite.SetCurRes(const Value: Integer);
begin
  FCurRes := Value;
  Self.fWhalf := (W / 2){ * fPosition.scaleX};
  Self.fHhalf := (H / 2){ * fPosition.scaleY};
end;

function tSprite.UnderTheMouse(const MouseX, MouseY: Double): boolean;
{var
  vDist: Double;
  vEX, vEY: Double; // �������� � �������� ����� �� �������
  vFi: Double; // ���� ����� �������
  vR: Double; // ������ ������� � ���������� �����     }
begin
  Result := Self.Shape.UnderTheMouse(MouseX, MouseY);
{  vEX := Self.x - MouseX;
  vEY := Self.y - MouseY;
  vDist := Sqrt(Sqr(vEX) + Sqr(vEY));

  if  (vEX <> 0) then
    vFi := ArcTan(vEY / vEX) else
       if vEY > 0
       then
         vFi := pi / 2
       else
         vFi := - pi / 2;

  vEx := Abs(Self.w * Self.ScaleX * 0.5);
  vEy := Abs(Self.h * Self.ScaleY * 0.5);
  vR := (vEX * vEY) /
        sqrt( sqr(vEX * cos(vFi)) + sqr(vEY * sin(vFi)) );

  Result := (vR >= vDist);
  //Inherited;   }
end;

end.




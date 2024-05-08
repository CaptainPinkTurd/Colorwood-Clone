Shader "Hidden/UI/Default (UIHsvModifier)"
{
  Properties
  {
    [PerRendererData] _MainTex ("Main Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
    _ParamTex ("Parameter Texture", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Color;
      
      uniform float4 _TextureSampleAdd;
      
      uniform float4 _ClipRect;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _ParamTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      int u_xlatb0;
      
      float4 u_xlat1;
      
      float u_xlat2;
      
      float u_xlat6;
      
      int u_xlatb6;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          u_xlat0 = in_v.color * _Color;
          
          out_v.color = u_xlat0;
          
          u_xlat0.xy = in_v.texcoord.xx * float2(4096.0, 0.000244140625);
          
          u_xlat2 = floor(u_xlat0.y);
          
          u_xlatb0 = u_xlat0.x>=(-u_xlat0.x);
          
          u_xlat0.xz = (int(u_xlatb0)) ? float2(4096.0, 0.000244140625) : float2(-4096.0, -0.000244140625);
          
          u_xlat6 = u_xlat2 * 4096.0;
          
          u_xlatb6 = u_xlat6>=(-u_xlat6);
          
          u_xlat1.xy = (int(u_xlatb6)) ? float2(4096.0, 0.000244140625) : float2(-4096.0, -0.000244140625);
          
          u_xlat2 = u_xlat2 * u_xlat1.y;
          
          u_xlat2 = fract(u_xlat2);
          
          u_xlat2 = u_xlat2 * u_xlat1.x;
          
          u_xlat1.y = u_xlat2 * 0.000244200259;
          
          u_xlat2 = u_xlat0.z * in_v.texcoord.x;
          
          u_xlat2 = fract(u_xlat2);
          
          u_xlat0.x = u_xlat2 * u_xlat0.x;
          
          u_xlat1.x = u_xlat0.x * 0.000244200259;
          
          out_v.texcoord.xy = u_xlat1.xy;
          
          out_v.texcoord2 = in_v.texcoord.y;
          
          out_v.texcoord1 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float2 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      bool2 u_xlatb0_d;
      
      float4 u_xlat16_1;
      
      int u_xlatb1;
      
      float4 u_xlat16_2;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float3 u_xlat16_5;
      
      float3 u_xlat16_6;
      
      float2 u_xlat7;
      
      bool2 u_xlatb7;
      
      int u_xlatb8;
      
      float2 u_xlat16_10;
      
      float u_xlat16_11;
      
      float2 u_xlat16_13;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlatb1 = u_xlat16_0.y>=u_xlat16_0.z;
          
          u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
          
          u_xlat16_10.xy = (-u_xlat16_0.zy) + u_xlat16_0.yz;
          
          u_xlat16_1.xy = u_xlat16_2.xx * u_xlat16_10.xy + u_xlat16_0.zy;
          
          u_xlat16_10.x = float(1.0);
          
          u_xlat16_10.y = float(-1.0);
          
          u_xlat16_1.zw = u_xlat16_2.xx * u_xlat16_10.xy + float2(-1.0, 0.666666687);
          
          u_xlat16_2.xyz = (-u_xlat16_1.xyw);
          
          u_xlat16_2.w = (-u_xlat16_0.x);
          
          u_xlat16_3.yzw = u_xlat16_1.yzx + u_xlat16_2.yzw;
          
          u_xlat16_3.x = u_xlat16_0.x + u_xlat16_2.x;
          
          u_xlatb8 = u_xlat16_0.x>=u_xlat16_1.x;
          
          u_xlat16_2.x = (u_xlatb8) ? 1.0 : 0.0;
          
          u_xlat16_10.x = u_xlat16_2.x * u_xlat16_3.w + u_xlat16_0.x;
          
          u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_3.yzx + u_xlat16_1.ywx;
          
          u_xlat16_3.x = min(u_xlat16_2.x, u_xlat16_10.x);
          
          u_xlat16_10.x = (-u_xlat16_2.x) + u_xlat16_10.x;
          
          u_xlat16_3.x = u_xlat16_2.w + (-u_xlat16_3.x);
          
          u_xlat16_11 = u_xlat16_3.x * 6.0 + 1.00000001e-10;
          
          u_xlat16_10.x = u_xlat16_10.x / u_xlat16_11;
          
          u_xlat16_10.x = u_xlat16_10.x + u_xlat16_2.z;
          
          u_xlat16_2.x = abs(u_xlat16_10.x);
          
          u_xlat16_10.x = u_xlat16_2.w + 1.00000001e-10;
          
          u_xlat16_2.z = u_xlat16_3.x / u_xlat16_10.x;
          
          u_xlat16_1.x = float(0.25);
          
          u_xlat16_1.z = float(0.75);
          
          u_xlat16_1.yw = float2(in_f.texcoord2);
          
          u_xlat16_3 = texture(_ParamTex, u_xlat16_1.xy);
          
          u_xlat16_0.xyz = texture(_ParamTex, u_xlat16_1.zw).xyz;
          
          u_xlat16_4.xyz = u_xlat16_0.xyz + float3(-0.5, -0.5, -0.5);
          
          u_xlat16_5.xyz = u_xlat16_2.xzw + (-u_xlat16_3.xyz);
          
          u_xlat16_6.xyz = -abs(u_xlat16_5.xyz) + float3(1.0, 1.0, 1.0);
          
          u_xlat16_5.xyz = min(abs(u_xlat16_5.xyz), u_xlat16_6.xyz);
          
          u_xlat16_13.xy = u_xlat16_5.yz * float2(0.100000001, 0.100000001);
          
          u_xlat16_10.x = max(u_xlat16_13.x, u_xlat16_5.x);
          
          u_xlat16_10.x = max(u_xlat16_13.y, u_xlat16_10.x);
          
          u_xlatb0_d.x = u_xlat16_3.w>=u_xlat16_10.x;
          
          u_xlat16_10.x = (u_xlatb0_d.x) ? 1.0 : 0.0;
          
          u_xlat16_2.xyz = u_xlat16_4.yzx * u_xlat16_10.xxx + u_xlat16_2.zwx;
          
          u_xlat16_4.xyz = u_xlat16_2.zzz + float3(1.0, 0.666666687, 0.333333343);
          
          u_xlat16_2.xy = u_xlat16_2.xy;
          
          u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
          
          u_xlat16_4.xyz = fract(u_xlat16_4.xyz);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz * float3(6.0, 6.0, 6.0) + float3(-3.0, -3.0, -3.0);
          
          u_xlat16_4.xyz = abs(u_xlat16_4.xyz) + float3(-1.0, -1.0, -1.0);
          
          u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
          
          u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
          
          u_xlat16_2.xzw = u_xlat16_2.xxx * u_xlat16_4.xyz + float3(1.0, 1.0, 1.0);
          
          u_xlat16_1.xyz = u_xlat16_2.yyy * u_xlat16_2.xzw + _TextureSampleAdd.xyz;
          
          u_xlatb0_d.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlat0_d.x = u_xlatb0_d.x ? float(1.0) : 0.0;
          
          u_xlat0_d.y = u_xlatb0_d.y ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb7.xy = greaterThanEqual(_ClipRect.zwzz, in_f.texcoord1.xyxx).xy;
          
          u_xlat7.x = u_xlatb7.x ? float(1.0) : 0.0;
          
          u_xlat7.y = u_xlatb7.y ? float(1.0) : 0.0;
      
      ;
          
          u_xlat0_d.xy = u_xlat0_d.xy * u_xlat7.xy;
          
          u_xlat0_d.x = u_xlat0_d.y * u_xlat0_d.x;
          
          u_xlat16_1.w = u_xlat16_0.w * u_xlat0_d.x + _TextureSampleAdd.w;
          
          out_f.color = u_xlat16_1 * in_f.color;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

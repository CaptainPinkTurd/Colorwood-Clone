Shader "Hidden/UI/Default (UIShiny)"
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
    Pass // ind: 1, name: Default
    {
      Name "Default"
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
          
          float2 texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord2 : TEXCOORD2;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 phase0_Output0_2;
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      bool4 u_xlatb1;
      
      float4 u_xlat2;
      
      bool4 u_xlatb2;
      
      float3 u_xlat3;
      
      float3 u_xlat4;
      
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
          
          u_xlat0 = in_v.texcoord.xxyy * float4(4096.0, 0.000244140625, 4096.0, 0.000244140625);
          
          u_xlat3.xz = floor(u_xlat0.yw);
          
          u_xlatb1 = greaterThanEqual(u_xlat0.xxzz, (-u_xlat0.xxzz));
          
          u_xlat1.x = (u_xlatb1.x) ? float(4096.0) : float(-4096.0);
          
          u_xlat1.y = (u_xlatb1.y) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat1.z = (u_xlatb1.z) ? float(4096.0) : float(-4096.0);
          
          u_xlat1.w = (u_xlatb1.w) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat2 = u_xlat3.xxzz * float4(4096.0, 4096.0, 4096.0, 4096.0);
          
          u_xlatb2 = greaterThanEqual(u_xlat2, (-u_xlat2.yyww));
          
          u_xlat2.x = (u_xlatb2.x) ? float(4096.0) : float(-4096.0);
          
          u_xlat2.y = (u_xlatb2.y) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat2.z = (u_xlatb2.z) ? float(4096.0) : float(-4096.0);
          
          u_xlat2.w = (u_xlatb2.w) ? float(0.000244140625) : float(-0.000244140625);
          
          u_xlat0.xy = u_xlat3.xz * u_xlat2.yw;
          
          u_xlat0.xy = fract(u_xlat0.xy);
          
          u_xlat0.xy = u_xlat0.xy * u_xlat2.xz;
          
          u_xlat0.yw = u_xlat0.xy * float2(0.000244200259, 0.000244200259);
          
          u_xlat4.xz = u_xlat1.yw * in_v.texcoord.xy;
          
          u_xlat4.xz = fract(u_xlat4.xz);
          
          u_xlat1.xy = u_xlat4.xz * u_xlat1.xz;
          
          u_xlat0.xz = u_xlat1.xy * float2(0.000244200259, 0.000244200259);
          
          phase0_Output0_2 = u_xlat0;
          
          out_v.texcoord1 = in_v.vertex;
          
          out_v.texcoord = phase0_Output0_2.xy;
          
          out_v.texcoord2 = phase0_Output0_2.zw;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat16_0;
      
      float2 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool2 u_xlatb1_d;
      
      float u_xlat16_2;
      
      float4 u_xlat3_d;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float2 u_xlat6;
      
      bool2 u_xlatb6;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0.x = float(0.25);
          
          u_xlat16_0.z = float(0.75);
          
          u_xlat16_0.yw = in_f.texcoord2.yy;
          
          u_xlat16_1 = texture(_ParamTex, u_xlat16_0.xy);
          
          u_xlat16_2 = texture(_ParamTex, u_xlat16_0.zw).x;
          
          u_xlat16_0.x = u_xlat16_1.x * 2.0 + -0.5;
          
          u_xlat16_0.x = (-u_xlat16_0.x) + in_f.texcoord2.x;
          
          u_xlat16_0.x = u_xlat16_0.x / u_xlat16_1.y;
          
          u_xlat16_0.x = min(abs(u_xlat16_0.x), 1.0);
          
          u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
          
          u_xlat16_4.x = float(1.0) / u_xlat16_1.z;
          
          u_xlat16_0.x = u_xlat16_4.x * u_xlat16_0.x;
          
          u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
          
          u_xlat16_4.x = u_xlat16_0.x * -2.0 + 3.0;
          
          u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
          
          u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4.x;
          
          u_xlat16_0.x = u_xlat16_0.x * 0.5;
          
          u_xlatb1_d.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlat1_d.x = u_xlatb1_d.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1_d.y ? float(1.0) : 0.0;
      
      ;
          
          u_xlatb6.xy = greaterThanEqual(_ClipRect.zwzz, in_f.texcoord1.xyxx).xy;
          
          u_xlat6.x = u_xlatb6.x ? float(1.0) : 0.0;
          
          u_xlat6.y = u_xlatb6.y ? float(1.0) : 0.0;
      
      ;
          
          u_xlat1_d.xy = u_xlat1_d.xy * u_xlat6.xy;
          
          u_xlat1_d.x = u_xlat1_d.y * u_xlat1_d.x;
          
          u_xlat16_3 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat3_d = u_xlat16_3 + _TextureSampleAdd;
          
          u_xlat3_d = u_xlat3_d * in_f.color;
          
          u_xlat1_d.x = u_xlat1_d.x * u_xlat3_d.w;
          
          u_xlat16_0.x = u_xlat16_0.x * u_xlat1_d.x;
          
          out_f.color.w = u_xlat1_d.x;
          
          u_xlat16_0.x = u_xlat16_1.w * u_xlat16_0.x;
          
          u_xlat16_4.xyz = u_xlat3_d.xyz * float3(7.0, 7.0, 7.0) + float3(-1.0, -1.0, -1.0);
          
          u_xlat16_4.xyz = float3(u_xlat16_2) * u_xlat16_4.xyz + float3(1.0, 1.0, 1.0);
          
          out_f.color.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz + u_xlat3_d.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}

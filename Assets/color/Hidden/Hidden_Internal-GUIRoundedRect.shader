Shader "Hidden/Internal-GUIRoundedRect"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
    _SrcBlend ("SrcBlend", float) = 5
    _DstBlend ("DstBlend", float) = 10
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend Zero Zero, One OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 unity_GUIClipTextureMatrix[4];
      
      uniform int _ManualTex2SRGB;
      
      uniform int _SrcBlend;
      
      uniform float _CornerRadiuses[4];
      
      uniform float _BorderWidths[4];
      
      uniform float _Rect[4];
      
      uniform int _SmoothCorners;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _GUIClipTexture;
      
      
      
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
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float2 u_xlat2;
      
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
          
          out_v.color = in_v.color;
          
          u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
          
          u_xlat0.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
          
          u_xlat0.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
          
          u_xlat0.xy = unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
          
          u_xlat2.xy = u_xlat0.yy * unity_GUIClipTextureMatrix[1].xy;
          
          u_xlat0.xy = unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
          
          out_v.texcoord1.xy = u_xlat0.xy + unity_GUIClipTextureMatrix[3].xy;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.texcoord2 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      bool2 u_xlatb0;
      
      float2 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool2 u_xlatb1;
      
      float4 u_xlat2_d;
      
      int2 u_xlati2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_5;
      
      float u_xlat6;
      
      float3 u_xlat16_6;
      
      bool3 u_xlatb6;
      
      float u_xlat12;
      
      int u_xlatb12;
      
      float u_xlat13;
      
      int u_xlatb13;
      
      float2 u_xlat15;
      
      float2 u_xlat16;
      
      float u_xlat18;
      
      int u_xlatb18;
      
      int u_xlati19;
      
      float u_xlat16_23;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _BorderWidths[0];
          
          u_xlat1_d.x = _BorderWidths[2];
          
          u_xlat12 = in_f.texcoord2.x + (-_Rect[0]);
          
          u_xlat12 = (-_Rect[2]) * 0.5 + u_xlat12;
          
          u_xlatb12 = 0.0>=u_xlat12;
          
          u_xlat18 = _Rect[0] + _Rect[2];
          
          u_xlat13 = in_f.texcoord2.y + (-_Rect[1]);
          
          u_xlat13 = (-_Rect[3]) * 0.5 + u_xlat13;
          
          u_xlatb13 = 0.0>=u_xlat13;
          
          u_xlati2.xy = (int(u_xlatb13)) ? int2(0, 1) : int2(3, 2);
          
          u_xlati19 = (u_xlatb12) ? u_xlati2.x : u_xlati2.y;
          
          u_xlat1_d.y = u_xlat18 + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat0_d.y = _Rect[0] + _CornerRadiuses[u_xlati19];
          
          u_xlat2_d.xy = (int(u_xlatb12)) ? u_xlat0_d.xy : u_xlat1_d.xy;
          
          u_xlat15.x = _BorderWidths[1];
          
          u_xlat16.x = _BorderWidths[3];
          
          u_xlat0_d.x = _Rect[1] + _Rect[3];
          
          u_xlat16.y = u_xlat0_d.x + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati19];
          
          u_xlat2_d.zw = (int(u_xlatb13)) ? u_xlat15.xy : u_xlat16.xy;
          
          u_xlat0_d.xy = (-u_xlat2_d.xz) + float2(_CornerRadiuses[u_xlati19]);
          
          u_xlat18 = u_xlat0_d.x / u_xlat0_d.y;
          
          u_xlat3.xy = (-u_xlat2_d.yw) + in_f.texcoord2.xy;
          
          u_xlat3.z = u_xlat18 * u_xlat3.y;
          
          u_xlat18 = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat1_d.x = dot(u_xlat3.xy, u_xlat3.xy);
          
          u_xlat1_d.x = sqrt(u_xlat1_d.x);
          
          u_xlat1_d.x = u_xlat1_d.x + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat18 = sqrt(u_xlat18);
          
          u_xlat18 = (-u_xlat0_d.x) + u_xlat18;
          
          u_xlatb0.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat0_d.xyxx).xy;
          
          u_xlatb0.x = u_xlatb0.y && u_xlatb0.x;
          
          u_xlat6 = dFdx(in_f.texcoord2.x);
          
          u_xlat6 = float(1.0) / abs(u_xlat6);
          
          u_xlat18 = u_xlat18 * u_xlat6 + 0.5;
          
          u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
          
          u_xlat6 = u_xlat1_d.x * u_xlat6 + 0.5;
          
          u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
          
          u_xlat0_d.x = (u_xlatb0.x) ? u_xlat18 : 1.0;
          
          u_xlatb1.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat2_d.xzxx).xy;
          
          u_xlatb18 = u_xlatb1.y || u_xlatb1.x;
          
          u_xlat0_d.x = u_xlatb18 ? u_xlat0_d.x : float(0.0);
          
          u_xlat6 = u_xlatb18 ? u_xlat6 : float(0.0);
          
          u_xlat18 = (-u_xlat6) + 1.0;
          
          u_xlatb6.x = u_xlat6==0.0;
          
          u_xlat18 = (_SmoothCorners != 0) ? u_xlat18 : 0.0;
          
          u_xlat0_d.x = (u_xlatb6.x) ? u_xlat0_d.x : u_xlat18;
          
          u_xlatb6.xz = greaterThanEqual(u_xlat2_d.yyww, in_f.texcoord2.xxyy).xz;
          
          u_xlatb1.xy = greaterThanEqual(in_f.texcoord2.xyxx, u_xlat2_d.ywyy).xy;
          
          u_xlatb6.x = (u_xlatb12) ? u_xlatb6.x : u_xlatb1.x;
          
          u_xlatb12 = (u_xlatb13) ? u_xlatb6.z : u_xlatb1.y;
          
          u_xlatb6.x = u_xlatb12 && u_xlatb6.x;
          
          u_xlat0_d.x = (u_xlatb6.x) ? u_xlat0_d.x : 1.0;
          
          u_xlat12 = _BorderWidths[0] + _BorderWidths[2];
          
          u_xlat12 = (-u_xlat12) + _Rect[2];
          
          u_xlat18 = _BorderWidths[0] + _Rect[0];
          
          u_xlat12 = u_xlat12 + u_xlat18;
          
          u_xlatb18 = in_f.texcoord2.x>=u_xlat18;
          
          u_xlatb12 = u_xlat12>=in_f.texcoord2.x;
          
          u_xlatb12 = u_xlatb12 && u_xlatb18;
          
          u_xlat18 = _BorderWidths[1] + _Rect[1];
          
          u_xlatb1.x = in_f.texcoord2.y>=u_xlat18;
          
          u_xlatb12 = u_xlatb12 && u_xlatb1.x;
          
          u_xlat1_d.x = _BorderWidths[1] + _BorderWidths[3];
          
          u_xlat1_d.x = (-u_xlat1_d.x) + _Rect[3];
          
          u_xlat18 = u_xlat18 + u_xlat1_d.x;
          
          u_xlatb18 = u_xlat18>=in_f.texcoord2.y;
          
          u_xlatb12 = u_xlatb18 && u_xlatb12;
          
          u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
          
          u_xlat6 = (u_xlatb6.x) ? 1.0 : u_xlat12;
          
          u_xlatb12 = 0.0<_BorderWidths[0];
          
          u_xlatb18 = 0.0<_BorderWidths[1];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlatb18 = 0.0<_BorderWidths[2];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlatb18 = 0.0<_BorderWidths[3];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlat16_6.x = (u_xlatb12) ? u_xlat6 : 1.0;
          
          u_xlat0_d.z = u_xlat16_6.x * u_xlat0_d.x;
          
          u_xlat16_6.z = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlat16_1 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_5.xyz = max(u_xlat16_1.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat2_d.xyz = log2(u_xlat16_5.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat2_d.xyz = exp2(u_xlat2_d.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat2_d.xyz = max(u_xlat2_d.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_5.xyz = (_ManualTex2SRGB != 0) ? u_xlat2_d.xyz : u_xlat16_1.xyz;
          
          u_xlat16_23 = u_xlat16_1.w * in_f.color.w;
          
          u_xlat0_d.x = u_xlat0_d.x * u_xlat16_23;
          
          u_xlat0_d.xz = u_xlat16_6.xz * u_xlat0_d.xz;
          
          u_xlat0_d.x = u_xlat16_6.z * u_xlat0_d.x;
          
          out_f.color.w = u_xlat0_d.x;
          
          u_xlat16_5.xyz = u_xlat16_5.xyz * in_f.color.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.zzz * u_xlat16_5.xyz;
          
          u_xlatb18 = _SrcBlend!=5;
          
          out_f.color.xyz = (int(u_xlatb18)) ? u_xlat0_d.xyz : u_xlat16_5.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixV[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 unity_GUIClipTextureMatrix[4];
      
      uniform int _ManualTex2SRGB;
      
      uniform int _SrcBlend;
      
      uniform float _CornerRadiuses[4];
      
      uniform float _BorderWidths[4];
      
      uniform float _Rect[4];
      
      uniform int _SmoothCorners;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D _GUIClipTexture;
      
      
      
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
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float2 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float2 u_xlat2;
      
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
          
          out_v.color = in_v.color;
          
          u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
          
          u_xlat0.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
          
          u_xlat0.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat0.xy;
          
          u_xlat0.xy = unity_MatrixV[3].xy * u_xlat0.ww + u_xlat0.xy;
          
          u_xlat2.xy = u_xlat0.yy * unity_GUIClipTextureMatrix[1].xy;
          
          u_xlat0.xy = unity_GUIClipTextureMatrix[0].xy * u_xlat0.xx + u_xlat2.xy;
          
          out_v.texcoord1.xy = u_xlat0.xy + unity_GUIClipTextureMatrix[3].xy;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.texcoord2 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      bool2 u_xlatb0;
      
      float2 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      bool2 u_xlatb1;
      
      float4 u_xlat2_d;
      
      int2 u_xlati2;
      
      float3 u_xlat3;
      
      float3 u_xlat16_5;
      
      float u_xlat6;
      
      float3 u_xlat16_6;
      
      bool3 u_xlatb6;
      
      float u_xlat12;
      
      int u_xlatb12;
      
      float u_xlat13;
      
      int u_xlatb13;
      
      float2 u_xlat15;
      
      float2 u_xlat16;
      
      float u_xlat18;
      
      int u_xlatb18;
      
      int u_xlati19;
      
      float u_xlat16_23;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _BorderWidths[0];
          
          u_xlat1_d.x = _BorderWidths[2];
          
          u_xlat12 = in_f.texcoord2.x + (-_Rect[0]);
          
          u_xlat12 = (-_Rect[2]) * 0.5 + u_xlat12;
          
          u_xlatb12 = 0.0>=u_xlat12;
          
          u_xlat18 = _Rect[0] + _Rect[2];
          
          u_xlat13 = in_f.texcoord2.y + (-_Rect[1]);
          
          u_xlat13 = (-_Rect[3]) * 0.5 + u_xlat13;
          
          u_xlatb13 = 0.0>=u_xlat13;
          
          u_xlati2.xy = (int(u_xlatb13)) ? int2(0, 1) : int2(3, 2);
          
          u_xlati19 = (u_xlatb12) ? u_xlati2.x : u_xlati2.y;
          
          u_xlat1_d.y = u_xlat18 + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat0_d.y = _Rect[0] + _CornerRadiuses[u_xlati19];
          
          u_xlat2_d.xy = (int(u_xlatb12)) ? u_xlat0_d.xy : u_xlat1_d.xy;
          
          u_xlat15.x = _BorderWidths[1];
          
          u_xlat16.x = _BorderWidths[3];
          
          u_xlat0_d.x = _Rect[1] + _Rect[3];
          
          u_xlat16.y = u_xlat0_d.x + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat15.y = _Rect[1] + _CornerRadiuses[u_xlati19];
          
          u_xlat2_d.zw = (int(u_xlatb13)) ? u_xlat15.xy : u_xlat16.xy;
          
          u_xlat0_d.xy = (-u_xlat2_d.xz) + float2(_CornerRadiuses[u_xlati19]);
          
          u_xlat18 = u_xlat0_d.x / u_xlat0_d.y;
          
          u_xlat3.xy = (-u_xlat2_d.yw) + in_f.texcoord2.xy;
          
          u_xlat3.z = u_xlat18 * u_xlat3.y;
          
          u_xlat18 = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat1_d.x = dot(u_xlat3.xy, u_xlat3.xy);
          
          u_xlat1_d.x = sqrt(u_xlat1_d.x);
          
          u_xlat1_d.x = u_xlat1_d.x + (-_CornerRadiuses[u_xlati19]);
          
          u_xlat18 = sqrt(u_xlat18);
          
          u_xlat18 = (-u_xlat0_d.x) + u_xlat18;
          
          u_xlatb0.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat0_d.xyxx).xy;
          
          u_xlatb0.x = u_xlatb0.y && u_xlatb0.x;
          
          u_xlat6 = dFdx(in_f.texcoord2.x);
          
          u_xlat6 = float(1.0) / abs(u_xlat6);
          
          u_xlat18 = u_xlat18 * u_xlat6 + 0.5;
          
          u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
          
          u_xlat6 = u_xlat1_d.x * u_xlat6 + 0.5;
          
          u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
          
          u_xlat0_d.x = (u_xlatb0.x) ? u_xlat18 : 1.0;
          
          u_xlatb1.xy = lessThan(float4(0.0, 0.0, 0.0, 0.0), u_xlat2_d.xzxx).xy;
          
          u_xlatb18 = u_xlatb1.y || u_xlatb1.x;
          
          u_xlat0_d.x = u_xlatb18 ? u_xlat0_d.x : float(0.0);
          
          u_xlat6 = u_xlatb18 ? u_xlat6 : float(0.0);
          
          u_xlat18 = (-u_xlat6) + 1.0;
          
          u_xlatb6.x = u_xlat6==0.0;
          
          u_xlat18 = (_SmoothCorners != 0) ? u_xlat18 : 0.0;
          
          u_xlat0_d.x = (u_xlatb6.x) ? u_xlat0_d.x : u_xlat18;
          
          u_xlatb6.xz = greaterThanEqual(u_xlat2_d.yyww, in_f.texcoord2.xxyy).xz;
          
          u_xlatb1.xy = greaterThanEqual(in_f.texcoord2.xyxx, u_xlat2_d.ywyy).xy;
          
          u_xlatb6.x = (u_xlatb12) ? u_xlatb6.x : u_xlatb1.x;
          
          u_xlatb12 = (u_xlatb13) ? u_xlatb6.z : u_xlatb1.y;
          
          u_xlatb6.x = u_xlatb12 && u_xlatb6.x;
          
          u_xlat0_d.x = (u_xlatb6.x) ? u_xlat0_d.x : 1.0;
          
          u_xlat12 = _BorderWidths[0] + _BorderWidths[2];
          
          u_xlat12 = (-u_xlat12) + _Rect[2];
          
          u_xlat18 = _BorderWidths[0] + _Rect[0];
          
          u_xlat12 = u_xlat12 + u_xlat18;
          
          u_xlatb18 = in_f.texcoord2.x>=u_xlat18;
          
          u_xlatb12 = u_xlat12>=in_f.texcoord2.x;
          
          u_xlatb12 = u_xlatb12 && u_xlatb18;
          
          u_xlat18 = _BorderWidths[1] + _Rect[1];
          
          u_xlatb1.x = in_f.texcoord2.y>=u_xlat18;
          
          u_xlatb12 = u_xlatb12 && u_xlatb1.x;
          
          u_xlat1_d.x = _BorderWidths[1] + _BorderWidths[3];
          
          u_xlat1_d.x = (-u_xlat1_d.x) + _Rect[3];
          
          u_xlat18 = u_xlat18 + u_xlat1_d.x;
          
          u_xlatb18 = u_xlat18>=in_f.texcoord2.y;
          
          u_xlatb12 = u_xlatb18 && u_xlatb12;
          
          u_xlat12 = (u_xlatb12) ? 0.0 : 1.0;
          
          u_xlat6 = (u_xlatb6.x) ? 1.0 : u_xlat12;
          
          u_xlatb12 = 0.0<_BorderWidths[0];
          
          u_xlatb18 = 0.0<_BorderWidths[1];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlatb18 = 0.0<_BorderWidths[2];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlatb18 = 0.0<_BorderWidths[3];
          
          u_xlatb12 = u_xlatb18 || u_xlatb12;
          
          u_xlat16_6.x = (u_xlatb12) ? u_xlat6 : 1.0;
          
          u_xlat0_d.z = u_xlat16_6.x * u_xlat0_d.x;
          
          u_xlat16_6.z = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlat16_1 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_5.xyz = max(u_xlat16_1.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat2_d.xyz = log2(u_xlat16_5.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat2_d.xyz = exp2(u_xlat2_d.xyz);
          
          u_xlat2_d.xyz = u_xlat2_d.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat2_d.xyz = max(u_xlat2_d.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_5.xyz = (_ManualTex2SRGB != 0) ? u_xlat2_d.xyz : u_xlat16_1.xyz;
          
          u_xlat16_23 = u_xlat16_1.w * in_f.color.w;
          
          u_xlat0_d.x = u_xlat0_d.x * u_xlat16_23;
          
          u_xlat0_d.xz = u_xlat16_6.xz * u_xlat0_d.xz;
          
          u_xlat0_d.x = u_xlat16_6.z * u_xlat0_d.x;
          
          out_f.color.w = u_xlat0_d.x;
          
          u_xlat16_5.xyz = u_xlat16_5.xyz * in_f.color.xyz;
          
          u_xlat0_d.xyz = u_xlat0_d.zzz * u_xlat16_5.xyz;
          
          u_xlatb18 = _SrcBlend!=5;
          
          out_f.color.xyz = (int(u_xlatb18)) ? u_xlat0_d.xyz : u_xlat16_5.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Internal-GUITextureClip"
}

Shader "Hidden/Internal-GUIRoundedRectWithColorPerBorder"
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
      
      uniform float4 _BorderColors[4];
      
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
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat1_d;
      
      float4 u_xlat16_1;
      
      int3 u_xlati1;
      
      int u_xlatb1;
      
      float3 u_xlat16_2;
      
      float4 u_xlat3;
      
      bool3 u_xlatb3;
      
      float4 u_xlat4;
      
      int u_xlati4;
      
      bool2 u_xlatb4;
      
      float4 u_xlat5;
      
      float4 u_xlat6;
      
      float4 u_xlat7;
      
      bool2 u_xlatb7;
      
      float3 u_xlat8;
      
      float3 u_xlat16_8;
      
      float3 u_xlat9;
      
      float3 u_xlat16_9;
      
      bool2 u_xlatb9;
      
      float u_xlat10;
      
      int u_xlatb10;
      
      int u_xlati12;
      
      int u_xlatb12;
      
      int u_xlatb13;
      
      float u_xlat18;
      
      int u_xlati18;
      
      int u_xlatb18;
      
      float u_xlat19;
      
      int u_xlatb19;
      
      float u_xlat21;
      
      int u_xlatb21;
      
      int u_xlati22;
      
      float u_xlat27;
      
      int u_xlati27;
      
      int u_xlatb27;
      
      float u_xlat28;
      
      float u_xlat29;
      
      float u_xlat16_29;
      
      int u_xlatb30;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = dFdx(in_f.texcoord2.x);
          
          u_xlat0_d.x = float(1.0) / abs(u_xlat0_d.x);
          
          u_xlat16_1 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_2.xyz = max(u_xlat16_1.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat9.xyz = log2(u_xlat16_2.xyz);
          
          u_xlat9.xyz = u_xlat9.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat9.xyz = exp2(u_xlat9.xyz);
          
          u_xlat9.xyz = u_xlat9.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat9.xyz = max(u_xlat9.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_2.xyz = (_ManualTex2SRGB != 0) ? u_xlat9.xyz : u_xlat16_1.xyz;
          
          u_xlat9.x = in_f.texcoord2.x + (-_Rect[0]);
          
          u_xlat9.x = (-_Rect[2]) * 0.5 + u_xlat9.x;
          
          u_xlat18 = in_f.texcoord2.y + (-_Rect[1]);
          
          u_xlat9.y = (-_Rect[3]) * 0.5 + u_xlat18;
          
          u_xlatb9.xy = greaterThanEqual(float4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyxx).xy;
          
          u_xlati1.xyz = (u_xlatb9.y) ? int3(0, 1, 2) : int3(3, 2, 8);
          
          u_xlati27 = (u_xlatb9.x) ? u_xlati1.x : u_xlati1.y;
          
          u_xlati1.x = (u_xlatb9.x) ? 1 : 4;
          
          u_xlat3.y = _Rect[0] + _CornerRadiuses[u_xlati27];
          
          u_xlat4.y = _Rect[1] + _CornerRadiuses[u_xlati27];
          
          u_xlat3.w = _BorderWidths[0] + _Rect[0];
          
          u_xlat4.w = _BorderWidths[1] + _Rect[1];
          
          u_xlat5.x = _Rect[0] + _Rect[2];
          
          u_xlat5.y = u_xlat5.x + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat5.w = u_xlat5.x + (-_BorderWidths[2]);
          
          u_xlat3.x = _Rect[0];
          
          u_xlat3.z = _BorderWidths[0];
          
          u_xlat5.z = _BorderWidths[2];
          
          u_xlat5 = (u_xlatb9.x) ? u_xlat3 : u_xlat5;
          
          u_xlat6.x = _Rect[1] + _Rect[3];
          
          u_xlat6.y = u_xlat6.x + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat6.w = u_xlat6.x + (-_BorderWidths[3]);
          
          u_xlat4.x = _Rect[1];
          
          u_xlat4.z = _BorderWidths[1];
          
          u_xlat6.z = _BorderWidths[3];
          
          u_xlat6 = (u_xlatb9.y) ? u_xlat4.yxzw : u_xlat6.yxzw;
          
          u_xlatb3.xy = greaterThanEqual(u_xlat5.ywyy, in_f.texcoord2.xxxx).xy;
          
          u_xlatb4.xy = greaterThanEqual(in_f.texcoord2.xxxx, u_xlat5.ywyy).xy;
          
          u_xlatb3.xy = (u_xlatb9.x) ? u_xlatb3.xy : u_xlatb4.xy;
          
          u_xlatb4.xy = greaterThanEqual(u_xlat6.xwxx, in_f.texcoord2.yyyy).xy;
          
          u_xlatb7.xy = greaterThanEqual(in_f.texcoord2.yyyy, u_xlat6.xwxx).xy;
          
          u_xlatb9.xy = (u_xlatb9.y) ? u_xlatb4.xy : u_xlatb7.xy;
          
          u_xlatb9.x = u_xlatb9.x && u_xlatb3.x;
          
          u_xlat10 = _BorderWidths[0] + _BorderWidths[2];
          
          u_xlat10 = (-u_xlat10) + _Rect[2];
          
          u_xlat3.x = _BorderWidths[1] + _BorderWidths[3];
          
          u_xlat3.x = (-u_xlat3.x) + _Rect[3];
          
          u_xlatb21 = in_f.texcoord2.x>=u_xlat3.w;
          
          u_xlat10 = u_xlat10 + u_xlat3.w;
          
          u_xlatb10 = u_xlat10>=in_f.texcoord2.x;
          
          u_xlatb10 = u_xlatb10 && u_xlatb21;
          
          u_xlatb21 = in_f.texcoord2.y>=u_xlat4.w;
          
          u_xlatb10 = u_xlatb10 && u_xlatb21;
          
          u_xlat3.x = u_xlat3.x + u_xlat4.w;
          
          u_xlatb3.x = u_xlat3.x>=in_f.texcoord2.y;
          
          u_xlatb10 = u_xlatb10 && u_xlatb3.x;
          
          u_xlatb3.xz = equal(int4(u_xlati27), int4(0, 0, 2, 0)).xz;
          
          u_xlatb3.x = u_xlatb3.z || u_xlatb3.x;
          
          u_xlatb21 = 0.0<_CornerRadiuses[u_xlati27];
          
          u_xlatb21 = u_xlatb9.x && u_xlatb21;
          
          u_xlatb30 = 0.0<u_xlat5.z;
          
          u_xlati4 = u_xlatb30 ? 1 : int(0);
          
          u_xlatb13 = 0.0<u_xlat6.z;
          
          u_xlati22 = u_xlatb13 ? 1 : int(0);
          
          u_xlati22 = u_xlati1.z * u_xlati22;
          
          u_xlati4 = u_xlati4 * u_xlati1.x + u_xlati22;
          
          u_xlatb12 = u_xlatb3.y && u_xlatb30;
          
          u_xlatb18 = u_xlatb9.y && u_xlatb13;
          
          u_xlati12 = u_xlatb12 ? 1 : int(0);
          
          u_xlati18 = u_xlatb18 ? 1 : int(0);
          
          u_xlati18 = u_xlati1.z * u_xlati18;
          
          u_xlati18 = u_xlati12 * u_xlati1.x + u_xlati18;
          
          u_xlati18 = (u_xlatb10) ? 0 : u_xlati18;
          
          u_xlati18 = (u_xlatb21) ? u_xlati4 : u_xlati18;
          
          u_xlati12 = u_xlati1.z + u_xlati1.x;
          
          u_xlat3.x = (u_xlatb3.x) ? 1.0 : -1.0;
          
          u_xlat7.xz = u_xlat5.wy;
          
          u_xlat7.yw = u_xlat6.wx;
          
          u_xlat6.x = u_xlat5.x;
          
          u_xlat4.xz = (-u_xlat7.yx) + u_xlat6.yx;
          
          u_xlat3.xz = u_xlat3.xx * u_xlat4.xz;
          
          u_xlat4.x = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat4.x = inversesqrt(u_xlat4.x);
          
          u_xlat3.xz = u_xlat3.xz * u_xlat4.xx;
          
          u_xlat3.xz = u_xlat3.xz * float2(100.0, 100.0) + u_xlat6.yx;
          
          u_xlat4.xz = (-u_xlat3.zx) + u_xlat6.xy;
          
          u_xlat3.xz = (-u_xlat3.xz) + in_f.texcoord2.yx;
          
          u_xlat21 = u_xlat3.z * u_xlat4.z;
          
          u_xlat3.x = u_xlat4.x * u_xlat3.x + (-u_xlat21);
          
          u_xlatb3.x = u_xlat3.x>=0.0;
          
          u_xlati1.x = (u_xlatb3.x) ? u_xlati1.x : u_xlati1.z;
          
          u_xlatb19 = u_xlati18!=u_xlati12;
          
          u_xlati18 = (u_xlatb19) ? u_xlati18 : u_xlati1.x;
          
          if(u_xlati18 == 0)
      {
              
              u_xlat16_8.xyz = u_xlat16_2.xyz * in_f.color.xyz;
              
              u_xlat16_29 = u_xlat16_1.w * in_f.color.w;
      
      }
          else
          
              {
              
              u_xlatb3.xyz = equal(int4(u_xlati18), int4(2, 4, 8, 0)).xyz;
              
              u_xlati18 = u_xlatb3.z ? 3 : int(0);
              
              u_xlati18 = (u_xlatb3.y) ? 2 : u_xlati18;
              
              u_xlati18 = (u_xlatb3.x) ? 1 : u_xlati18;
              
              u_xlat8.xyz = u_xlat16_2.xyz * _BorderColors[u_xlati18].xyz;
              
              u_xlat29 = u_xlat16_1.w * _BorderColors[u_xlati18].w;
              
              u_xlat16_8.xyz = u_xlat8.xyz;
              
              u_xlat16_29 = u_xlat29;
      
      }
          
          u_xlatb18 = u_xlatb30 || u_xlatb13;
          
          u_xlat3.xy = (-u_xlat7.zw) + in_f.texcoord2.xy;
          
          u_xlat1_d = dot(u_xlat3.xy, u_xlat3.xy);
          
          u_xlat1_d = sqrt(u_xlat1_d);
          
          u_xlat1_d = u_xlat1_d + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat1_d = u_xlat1_d * u_xlat0_d.x + 0.5;
          
          u_xlat1_d = clamp(u_xlat1_d, 0.0, 1.0);
          
          u_xlat1_d = u_xlatb18 ? u_xlat1_d : float(0.0);
          
          u_xlat19 = (-u_xlat5.z) + _CornerRadiuses[u_xlati27];
          
          u_xlat27 = (-u_xlat6.z) + _CornerRadiuses[u_xlati27];
          
          u_xlat28 = u_xlat19 / u_xlat27;
          
          u_xlat3.z = u_xlat28 * u_xlat3.y;
          
          u_xlat28 = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat28 = sqrt(u_xlat28);
          
          u_xlat28 = (-u_xlat19) + u_xlat28;
          
          u_xlat0_d.x = u_xlat28 * u_xlat0_d.x + 0.5;
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlatb19 = 0.0<u_xlat19;
          
          u_xlatb27 = 0.0<u_xlat27;
          
          u_xlatb27 = u_xlatb27 && u_xlatb19;
          
          u_xlat0_d.x = (u_xlatb27) ? u_xlat0_d.x : 1.0;
          
          u_xlat0_d.x = u_xlatb18 ? u_xlat0_d.x : float(0.0);
          
          u_xlatb18 = u_xlat1_d==0.0;
          
          u_xlat27 = (-u_xlat1_d) + 1.0;
          
          u_xlat0_d.x = (u_xlatb18) ? u_xlat0_d.x : u_xlat27;
          
          u_xlat0_d.x = (u_xlatb9.x) ? u_xlat0_d.x : 1.0;
          
          u_xlat18 = u_xlat0_d.x * u_xlat16_29;
          
          u_xlat27 = (u_xlatb10) ? 0.0 : 1.0;
          
          u_xlat16_9.x = (u_xlatb9.x) ? 1.0 : u_xlat27;
          
          u_xlat0_d.z = u_xlat16_9.x * u_xlat18;
          
          u_xlat16_9.z = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlatb1 = _SrcBlend!=5;
          
          u_xlat0_d.xz = u_xlat16_9.xz * u_xlat0_d.xz;
          
          u_xlat0_d.x = u_xlat16_9.z * u_xlat0_d.x;
          
          u_xlat0_d.xyw = u_xlat0_d.xxx * u_xlat16_8.xyz;
          
          out_f.color.xyz = (int(u_xlatb1)) ? u_xlat0_d.xyw : u_xlat16_8.xyz;
          
          out_f.color.w = u_xlat0_d.z;
          
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
      
      uniform float4 _BorderColors[4];
      
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
      
      
      
      float4 u_xlat0_d;
      
      float u_xlat1_d;
      
      float4 u_xlat16_1;
      
      int3 u_xlati1;
      
      int u_xlatb1;
      
      float3 u_xlat16_2;
      
      float4 u_xlat3;
      
      bool3 u_xlatb3;
      
      float4 u_xlat4;
      
      int u_xlati4;
      
      bool2 u_xlatb4;
      
      float4 u_xlat5;
      
      float4 u_xlat6;
      
      float4 u_xlat7;
      
      bool2 u_xlatb7;
      
      float3 u_xlat8;
      
      float3 u_xlat16_8;
      
      float3 u_xlat9;
      
      float3 u_xlat16_9;
      
      bool2 u_xlatb9;
      
      float u_xlat10;
      
      int u_xlatb10;
      
      int u_xlati12;
      
      int u_xlatb12;
      
      int u_xlatb13;
      
      float u_xlat18;
      
      int u_xlati18;
      
      int u_xlatb18;
      
      float u_xlat19;
      
      int u_xlatb19;
      
      float u_xlat21;
      
      int u_xlatb21;
      
      int u_xlati22;
      
      float u_xlat27;
      
      int u_xlati27;
      
      int u_xlatb27;
      
      float u_xlat28;
      
      float u_xlat29;
      
      float u_xlat16_29;
      
      int u_xlatb30;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = dFdx(in_f.texcoord2.x);
          
          u_xlat0_d.x = float(1.0) / abs(u_xlat0_d.x);
          
          u_xlat16_1 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_2.xyz = max(u_xlat16_1.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat9.xyz = log2(u_xlat16_2.xyz);
          
          u_xlat9.xyz = u_xlat9.xyz * float3(0.416666657, 0.416666657, 0.416666657);
          
          u_xlat9.xyz = exp2(u_xlat9.xyz);
          
          u_xlat9.xyz = u_xlat9.xyz * float3(1.05499995, 1.05499995, 1.05499995) + float3(-0.0549999997, -0.0549999997, -0.0549999997);
          
          u_xlat9.xyz = max(u_xlat9.xyz, float3(0.0, 0.0, 0.0));
          
          u_xlat16_2.xyz = (_ManualTex2SRGB != 0) ? u_xlat9.xyz : u_xlat16_1.xyz;
          
          u_xlat9.x = in_f.texcoord2.x + (-_Rect[0]);
          
          u_xlat9.x = (-_Rect[2]) * 0.5 + u_xlat9.x;
          
          u_xlat18 = in_f.texcoord2.y + (-_Rect[1]);
          
          u_xlat9.y = (-_Rect[3]) * 0.5 + u_xlat18;
          
          u_xlatb9.xy = greaterThanEqual(float4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyxx).xy;
          
          u_xlati1.xyz = (u_xlatb9.y) ? int3(0, 1, 2) : int3(3, 2, 8);
          
          u_xlati27 = (u_xlatb9.x) ? u_xlati1.x : u_xlati1.y;
          
          u_xlati1.x = (u_xlatb9.x) ? 1 : 4;
          
          u_xlat3.y = _Rect[0] + _CornerRadiuses[u_xlati27];
          
          u_xlat4.y = _Rect[1] + _CornerRadiuses[u_xlati27];
          
          u_xlat3.w = _BorderWidths[0] + _Rect[0];
          
          u_xlat4.w = _BorderWidths[1] + _Rect[1];
          
          u_xlat5.x = _Rect[0] + _Rect[2];
          
          u_xlat5.y = u_xlat5.x + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat5.w = u_xlat5.x + (-_BorderWidths[2]);
          
          u_xlat3.x = _Rect[0];
          
          u_xlat3.z = _BorderWidths[0];
          
          u_xlat5.z = _BorderWidths[2];
          
          u_xlat5 = (u_xlatb9.x) ? u_xlat3 : u_xlat5;
          
          u_xlat6.x = _Rect[1] + _Rect[3];
          
          u_xlat6.y = u_xlat6.x + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat6.w = u_xlat6.x + (-_BorderWidths[3]);
          
          u_xlat4.x = _Rect[1];
          
          u_xlat4.z = _BorderWidths[1];
          
          u_xlat6.z = _BorderWidths[3];
          
          u_xlat6 = (u_xlatb9.y) ? u_xlat4.yxzw : u_xlat6.yxzw;
          
          u_xlatb3.xy = greaterThanEqual(u_xlat5.ywyy, in_f.texcoord2.xxxx).xy;
          
          u_xlatb4.xy = greaterThanEqual(in_f.texcoord2.xxxx, u_xlat5.ywyy).xy;
          
          u_xlatb3.xy = (u_xlatb9.x) ? u_xlatb3.xy : u_xlatb4.xy;
          
          u_xlatb4.xy = greaterThanEqual(u_xlat6.xwxx, in_f.texcoord2.yyyy).xy;
          
          u_xlatb7.xy = greaterThanEqual(in_f.texcoord2.yyyy, u_xlat6.xwxx).xy;
          
          u_xlatb9.xy = (u_xlatb9.y) ? u_xlatb4.xy : u_xlatb7.xy;
          
          u_xlatb9.x = u_xlatb9.x && u_xlatb3.x;
          
          u_xlat10 = _BorderWidths[0] + _BorderWidths[2];
          
          u_xlat10 = (-u_xlat10) + _Rect[2];
          
          u_xlat3.x = _BorderWidths[1] + _BorderWidths[3];
          
          u_xlat3.x = (-u_xlat3.x) + _Rect[3];
          
          u_xlatb21 = in_f.texcoord2.x>=u_xlat3.w;
          
          u_xlat10 = u_xlat10 + u_xlat3.w;
          
          u_xlatb10 = u_xlat10>=in_f.texcoord2.x;
          
          u_xlatb10 = u_xlatb10 && u_xlatb21;
          
          u_xlatb21 = in_f.texcoord2.y>=u_xlat4.w;
          
          u_xlatb10 = u_xlatb10 && u_xlatb21;
          
          u_xlat3.x = u_xlat3.x + u_xlat4.w;
          
          u_xlatb3.x = u_xlat3.x>=in_f.texcoord2.y;
          
          u_xlatb10 = u_xlatb10 && u_xlatb3.x;
          
          u_xlatb3.xz = equal(int4(u_xlati27), int4(0, 0, 2, 0)).xz;
          
          u_xlatb3.x = u_xlatb3.z || u_xlatb3.x;
          
          u_xlatb21 = 0.0<_CornerRadiuses[u_xlati27];
          
          u_xlatb21 = u_xlatb9.x && u_xlatb21;
          
          u_xlatb30 = 0.0<u_xlat5.z;
          
          u_xlati4 = u_xlatb30 ? 1 : int(0);
          
          u_xlatb13 = 0.0<u_xlat6.z;
          
          u_xlati22 = u_xlatb13 ? 1 : int(0);
          
          u_xlati22 = u_xlati1.z * u_xlati22;
          
          u_xlati4 = u_xlati4 * u_xlati1.x + u_xlati22;
          
          u_xlatb12 = u_xlatb3.y && u_xlatb30;
          
          u_xlatb18 = u_xlatb9.y && u_xlatb13;
          
          u_xlati12 = u_xlatb12 ? 1 : int(0);
          
          u_xlati18 = u_xlatb18 ? 1 : int(0);
          
          u_xlati18 = u_xlati1.z * u_xlati18;
          
          u_xlati18 = u_xlati12 * u_xlati1.x + u_xlati18;
          
          u_xlati18 = (u_xlatb10) ? 0 : u_xlati18;
          
          u_xlati18 = (u_xlatb21) ? u_xlati4 : u_xlati18;
          
          u_xlati12 = u_xlati1.z + u_xlati1.x;
          
          u_xlat3.x = (u_xlatb3.x) ? 1.0 : -1.0;
          
          u_xlat7.xz = u_xlat5.wy;
          
          u_xlat7.yw = u_xlat6.wx;
          
          u_xlat6.x = u_xlat5.x;
          
          u_xlat4.xz = (-u_xlat7.yx) + u_xlat6.yx;
          
          u_xlat3.xz = u_xlat3.xx * u_xlat4.xz;
          
          u_xlat4.x = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat4.x = inversesqrt(u_xlat4.x);
          
          u_xlat3.xz = u_xlat3.xz * u_xlat4.xx;
          
          u_xlat3.xz = u_xlat3.xz * float2(100.0, 100.0) + u_xlat6.yx;
          
          u_xlat4.xz = (-u_xlat3.zx) + u_xlat6.xy;
          
          u_xlat3.xz = (-u_xlat3.xz) + in_f.texcoord2.yx;
          
          u_xlat21 = u_xlat3.z * u_xlat4.z;
          
          u_xlat3.x = u_xlat4.x * u_xlat3.x + (-u_xlat21);
          
          u_xlatb3.x = u_xlat3.x>=0.0;
          
          u_xlati1.x = (u_xlatb3.x) ? u_xlati1.x : u_xlati1.z;
          
          u_xlatb19 = u_xlati18!=u_xlati12;
          
          u_xlati18 = (u_xlatb19) ? u_xlati18 : u_xlati1.x;
          
          if(u_xlati18 == 0)
      {
              
              u_xlat16_8.xyz = u_xlat16_2.xyz * in_f.color.xyz;
              
              u_xlat16_29 = u_xlat16_1.w * in_f.color.w;
      
      }
          else
          
              {
              
              u_xlatb3.xyz = equal(int4(u_xlati18), int4(2, 4, 8, 0)).xyz;
              
              u_xlati18 = u_xlatb3.z ? 3 : int(0);
              
              u_xlati18 = (u_xlatb3.y) ? 2 : u_xlati18;
              
              u_xlati18 = (u_xlatb3.x) ? 1 : u_xlati18;
              
              u_xlat8.xyz = u_xlat16_2.xyz * _BorderColors[u_xlati18].xyz;
              
              u_xlat29 = u_xlat16_1.w * _BorderColors[u_xlati18].w;
              
              u_xlat16_8.xyz = u_xlat8.xyz;
              
              u_xlat16_29 = u_xlat29;
      
      }
          
          u_xlatb18 = u_xlatb30 || u_xlatb13;
          
          u_xlat3.xy = (-u_xlat7.zw) + in_f.texcoord2.xy;
          
          u_xlat1_d = dot(u_xlat3.xy, u_xlat3.xy);
          
          u_xlat1_d = sqrt(u_xlat1_d);
          
          u_xlat1_d = u_xlat1_d + (-_CornerRadiuses[u_xlati27]);
          
          u_xlat1_d = u_xlat1_d * u_xlat0_d.x + 0.5;
          
          u_xlat1_d = clamp(u_xlat1_d, 0.0, 1.0);
          
          u_xlat1_d = u_xlatb18 ? u_xlat1_d : float(0.0);
          
          u_xlat19 = (-u_xlat5.z) + _CornerRadiuses[u_xlati27];
          
          u_xlat27 = (-u_xlat6.z) + _CornerRadiuses[u_xlati27];
          
          u_xlat28 = u_xlat19 / u_xlat27;
          
          u_xlat3.z = u_xlat28 * u_xlat3.y;
          
          u_xlat28 = dot(u_xlat3.xz, u_xlat3.xz);
          
          u_xlat28 = sqrt(u_xlat28);
          
          u_xlat28 = (-u_xlat19) + u_xlat28;
          
          u_xlat0_d.x = u_xlat28 * u_xlat0_d.x + 0.5;
          
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          u_xlatb19 = 0.0<u_xlat19;
          
          u_xlatb27 = 0.0<u_xlat27;
          
          u_xlatb27 = u_xlatb27 && u_xlatb19;
          
          u_xlat0_d.x = (u_xlatb27) ? u_xlat0_d.x : 1.0;
          
          u_xlat0_d.x = u_xlatb18 ? u_xlat0_d.x : float(0.0);
          
          u_xlatb18 = u_xlat1_d==0.0;
          
          u_xlat27 = (-u_xlat1_d) + 1.0;
          
          u_xlat0_d.x = (u_xlatb18) ? u_xlat0_d.x : u_xlat27;
          
          u_xlat0_d.x = (u_xlatb9.x) ? u_xlat0_d.x : 1.0;
          
          u_xlat18 = u_xlat0_d.x * u_xlat16_29;
          
          u_xlat27 = (u_xlatb10) ? 0.0 : 1.0;
          
          u_xlat16_9.x = (u_xlatb9.x) ? 1.0 : u_xlat27;
          
          u_xlat0_d.z = u_xlat16_9.x * u_xlat18;
          
          u_xlat16_9.z = texture(_GUIClipTexture, in_f.texcoord1.xy).w;
          
          u_xlatb1 = _SrcBlend!=5;
          
          u_xlat0_d.xz = u_xlat16_9.xz * u_xlat0_d.xz;
          
          u_xlat0_d.x = u_xlat16_9.z * u_xlat0_d.x;
          
          u_xlat0_d.xyw = u_xlat0_d.xxx * u_xlat16_8.xyz;
          
          out_f.color.xyz = (int(u_xlatb1)) ? u_xlat0_d.xyw : u_xlat16_8.xyz;
          
          out_f.color.w = u_xlat0_d.z;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Internal-GUITextureClip"
}

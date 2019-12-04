using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[ImageEffectAllowedInSceneView]
public class Outline : MonoBehaviour {
    public Material mat;
    public bool dCam;

    void OnRenderImage(RenderTexture source, RenderTexture destination) {
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
        Graphics.Blit(source, destination, mat);

    }

    void Start() {
        if (dCam) {
            UnityEngine.Rendering.CommandBuffer cmd = new UnityEngine.Rendering.CommandBuffer();
            cmd.SetGlobalTexture("_DEEEPTH", UnityEngine.Rendering.BuiltinRenderTextureType.Depth);
            GetComponent<Camera>().AddCommandBuffer(UnityEngine.Rendering.CameraEvent.AfterDepthTexture, cmd);
        }
    }
}

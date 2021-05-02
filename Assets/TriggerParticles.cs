using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerParticles : MonoBehaviour
{

    public GameObject ParticleSystem;
    public bool isTriggered;
    // Start is called before the first frame update
    void Start()
    {
        ParticleSystem.SetActive(false);
        isTriggered = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator OnTriggerEnter(Collider other)
    {
        if (!isTriggered)
        {
            ParticleSystem.SetActive(true);
            var shape = ParticleSystem.GetComponent<ParticleSystem>().shape;
            shape.arcMode = ParticleSystemShapeMultiModeValue.Loop;
            yield return new WaitForSeconds(2);
            shape.arcMode = ParticleSystemShapeMultiModeValue.Random;
            isTriggered = true;
            //UnityEngine.RenderSettings.fogDensity = 0.25F;
            UnityEngine.RenderSettings.fogColor = UnityEngine.Color.red;
        }
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PowerUp : MonoBehaviour
{
    public MonoBehaviour script;
    public string methodToCall;
    public ParticleSystem onPickupParticles;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            //Debug.Log(other.gameObject.name);
            this.gameObject.SetActive(false);
            onPickupParticles.Play();
            script.Invoke(methodToCall, 0F);
            
        }
    }
}

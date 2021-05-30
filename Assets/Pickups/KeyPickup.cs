using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyPickup : MonoBehaviour
{

    public GameObject keyToSpawn;
    public ParticleSystem onPickupParticles;
    // Start is called before the first frame update
    void Start()
    {
        keyToSpawn.SetActive(false);
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
            keyToSpawn.SetActive(true);
        }
    }
}

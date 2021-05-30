using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestructiblePickup : MonoBehaviour
{
    public target ToDestroy;
    public GameObject Pickup;
    // Start is called before the first frame update
    void Start()
    {
        Pickup.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        if (ToDestroy.health <= 0F)
        {
            ToDestroy.gameObject.SetActive(false);
            Pickup.SetActive(true);
            //Pickup.GetComponent<AudioSource>().PlayOneShot();
            Destroy(this);
        }
    }
}

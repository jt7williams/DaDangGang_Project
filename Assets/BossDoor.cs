using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossDoor : MonoBehaviour
{

    public GameObject sigil1;
    public GameObject sigil2;
    public GameObject sigil3;
    public GameObject fireDoor;
    public GameObject door;
    private bool doorOpened;
    // Start is called before the first frame update
    void Start()
    {
        doorOpened = false;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator OnTriggerEnter(Collider other)
    {
        if (!doorOpened)
        {
            if (sigil1.activeSelf && sigil2.activeSelf && sigil3.activeSelf)
            {
                doorOpened = true;
                fireDoor.GetComponent<ParticleSystem>().Play();
                yield return new WaitForSeconds(2);
                door.SetActive(false);
            }
        }
    }
}

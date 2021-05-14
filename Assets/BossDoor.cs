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
    public GameObject floor;
    private bool doorOpened;
    // Start is called before the first frame update
    void Start()
    {
        doorOpened = false;
        floor.GetComponent<Renderer>().material.color = new Color(39F/256F, 207F/256F, 75F/256F);
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
                floor.GetComponent<Renderer>().material.color = Color.white;
                yield return new WaitForSeconds(2);
                door.SetActive(false);
                floor.GetComponent<Renderer>().material.color = Color.black;
            }
            else
            {
                doorOpened = true;
                for (int i = 0; i < 3; ++i)
                {
                    floor.GetComponent<Renderer>().material.color = Color.red;
                    yield return new WaitForSeconds(0.5F);
                    floor.GetComponent<Renderer>().material.color = Color.black;
                    yield return new WaitForSeconds(0.5F);
                }
                floor.GetComponent<Renderer>().material.color = new Color(39F / 256F, 207F / 256F, 75F / 256F);
                doorOpened = false;
            }
        }
    }
}

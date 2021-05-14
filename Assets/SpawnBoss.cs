using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnBoss : MonoBehaviour
{
    public GameObject sigil1;
    public GameObject sigil2;
    public GameObject sigil3;
    public GameObject sigil4;
    public GameObject sigil5;
    public GameObject fireRing;
    public GameObject boss;
    public GameObject floor;
    private bool bossSpawned;
    // Start is called before the first frame update
    void Start()
    {
        boss.SetActive(false);
        bossSpawned = false;
        floor.GetComponent<Renderer>().material.color = new Color(5F / 256F, 93F / 256F, 245F / 256F);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator OnTriggerEnter(Collider other)
    {
        if (!bossSpawned)
        {
            if (sigil1.activeSelf && sigil2.activeSelf && sigil3.activeSelf && sigil4.activeSelf && sigil5.activeSelf)
            {
                bossSpawned = true;
                fireRing.SetActive(true);
                var main = fireRing.GetComponent<ParticleSystem>().main;
                main.startSpeed = 50F;
                floor.GetComponent<Renderer>().material.color = Color.white;
                yield return new WaitForSeconds(7);
                floor.GetComponent<Renderer>().material.color = Color.black;
                fireRing.GetComponent<ParticleSystem>().emissionRate = 0F;
                yield return new WaitForSeconds(1);
                fireRing.SetActive(false);
                boss.SetActive(true);
            }
            else
            {
                bossSpawned = true;
                for (int i = 0; i < 3; ++i)
                {
                    floor.GetComponent<Renderer>().material.color = Color.red;
                    yield return new WaitForSeconds(0.5F);
                    floor.GetComponent<Renderer>().material.color = Color.black;
                    yield return new WaitForSeconds(0.5F);
                }
                floor.GetComponent<Renderer>().material.color = new Color(5F / 256F, 93F / 256F, 245F / 256F);
                bossSpawned = false;
            }
        }
    }
}

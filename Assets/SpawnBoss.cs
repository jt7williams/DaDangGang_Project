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
    private bool bossSpawned;
    // Start is called before the first frame update
    void Start()
    {
        boss.SetActive(false);
        bossSpawned = false;
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
                fireRing.SetActive(true);
                var main = fireRing.GetComponent<ParticleSystem>().main;
                main.startSpeed = 50F;
                yield return new WaitForSeconds(7);
                fireRing.GetComponent<ParticleSystem>().emissionRate = 0F;
                yield return new WaitForSeconds(1);
                fireRing.SetActive(false);
                boss.SetActive(true);
                bossSpawned = true;
            }
        }
    }
}

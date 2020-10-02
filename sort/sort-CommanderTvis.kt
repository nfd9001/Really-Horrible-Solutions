import kotlin.random.Random
import kotlin.system.measureTimeMillis

val list = List(12) { Random.nextInt(0, 100) }

fun <T> Iterable<T>.bozoSorted(): List<T> where T : Comparable<T> {
    fun isSorted(origin: List<T>): Boolean {
        for (i in 0..origin.size - 2) if (origin[i] > origin[i + 1]) return false
        return true
    }

    val list = toMutableList()
    if (list.size == 1) return list

    var slot1: Int
    var slot2: Int
    var temp: T

    while (!isSorted(list)) {
        slot1 = Random.nextInt(list.size)
        slot2 = Random.nextInt(list.size)
        temp = list[slot1]
        list[slot1] = list[slot2]
        list[slot2] = temp
    }

    return list
}

fun <T> Iterable<T>.stoogeSorted(): List<T> where T : Comparable<T> {
    val list = toMutableList()
    if (list.size == 1) return list

    fun visit(l: Int, h: Int) {
        if (l >= h) return

        if (list[l] > list[h]) {
            val t = list[l]
            list[l] = list[h]
            list[h] = t
        }

        if (h - l + 1 > 2) {
            val t = (h - l + 1) / 3
            visit(l, h - t)
            visit(l + t, h)
            visit(l, h - t)
        }
    }

    visit(0, list.lastIndex)
    return list
}

fun <T> Iterable<T>.shuffleSorted(): List<T> where T : Comparable<T> {
    fun isSorted(origin: List<T>): Boolean {
        for (i in 0..origin.size - 2) if (origin[i] > origin[i + 1]) return false
        return true
    }

    val list = toMutableList()
    if (list.size == 1) return list
    while (!isSorted(list)) list.shuffle()
    return list
}

fun main() {
    println(list)

    measureTimeMillis {
        println(list.stoogeSorted())
    }.also { println("Stooge sort: $it") }

    measureTimeMillis {
        println(list.bozoSorted())
    }.also { println("Bozo sort: $it") }

    measureTimeMillis {
        println(list.shuffleSorted())
    }.also { println("Shuffle sort: $it") }
}

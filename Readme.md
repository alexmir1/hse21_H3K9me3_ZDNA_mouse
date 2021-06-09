# hse21_H3K9me3_ZDNA_mouse
Организм: mouse.

Структура ДНК: G4_chip.

Гистоновая метка: H3K9me3.

Тип клеток: MEL.

Chip-seq эксперименты: https://www.encodeproject.org/files/ENCFF725BPX/, https://www.encodeproject.org/files/ENCFF175TIH/

## Анализ пиков гистоновой метки
### Скачиваем и распаковываем файлы
```
wget https://www.encodeproject.org/files/ENCFF725BPX/@@download/ENCFF725BPX.bed.gz
wget https://www.encodeproject.org/files/ENCFF175TIH/@@download/ENCFF175TIH.bed.gz
zcat ENCFF725BPX.bed.gz  |  cut -f1-5 > H3K9me3_MEL.ENCFF725BPX.mm10.bed
zcat ENCFF175TIH.bed.gz  |  cut -f1-5 > H3K9me3_MEL.ENCFF175TIH.mm10.bed
```
### Гистограмма длин участков 
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/len_hist.H3K9me3_MEL.ENCFF725BPX.mm10.png)
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/len_hist.H3K9me3_MEL.ENCFF175TIH.mm10.png)
### Выкидываем слишком длинные пики
Для обоих эксперементов я решил выкинуть пики длиннее 600
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/filter_peaks.H3K9me3_MEL.ENCFF725BPX.mm10.filtered.hist.png)
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/filter_peaks.H3K9me3_MEL.ENCFF175TIH.mm10.filtered.hist.png)
### Смотрим, где располагаются пики гистоновой метки относительно аннотированных генов
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/chip_seeker.H3K9me3_MEL.ENCFF725BPX.mm10.filtered.plotAnnoPie.png)
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/chip_seeker.H3K9me3_MEL.ENCFF175TIH.mm10.filtered.plotAnnoPie.png)
### Объединяем два набора отфильтрованных ChIP-seq пиков с помощью утилиты bedtools merge
```
cat *.filtered.bed | sort -k1,1 -k2,2n | bedtools merge > H3K9me3_MEL.merge.mm10.bed
```
### Визуализируем исходные два набора ChIP-seq пиков, а также их объединение в геномном браузере
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/genc_merge.png)
## Анализ участков вторичной структуры ДНК
### Строим распределение длин участков вторичной структуры ДНК
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/len_hist.mouseZ-DNA1.png)
### Смотрим, где располагаются участки структуры ДНК относительно аннотированных генов
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/chip_seeker.mouseZ-DNA1.plotAnnoPie.png)
## Анализ пересечений гистоновой метки и стр-ры ДНК
```
bedtools intersect -a mouseZ-DNA1.bed -b H3K9me3_MEL.merge.mm10.bed > H3K9me3_MEL.intersect_with_mouseZ-DNA1.bed
```
### Пересечения гистоновой меткой и структуры ДНК
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/len_hist.H3K9me3_MEL.intersect_with_mouseZ-DNA1.png)
Всего 3 пересечения
### Визуализируем в геномном браузере исходные участки структуры ДНК
![alt text](https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/images/gen_mouseZ.png)

http://genome.ucsc.edu/s/alexmir/hse21_H3K9me3_ZDNA_mouse
### Ассоциируем полученные пересечения с ближайшими генами
Я увеличил границы поиска до (-1000000, 1000000), чтобы по трём пересечениям получить хоть какие-то гены. Получилось 17 генов.
### GO-анализ
Результат: "No statistically significant results"
Все результаты в https://github.com/alexmir1/hse21_H3K9me3_ZDNA_mouse/raw/master/data/go-analysis.txt

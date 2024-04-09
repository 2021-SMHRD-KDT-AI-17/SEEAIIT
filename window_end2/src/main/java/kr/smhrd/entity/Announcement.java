package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class Announcement {
   
   public int ann_idx;
   @NonNull public String ann_title;
   @NonNull public String ann_content;
   public String ann_dt;
   @NonNull public String teacher_id;

}
﻿using System.Collections.Generic;

namespace FileSharing.Services.Dtos
{
    public class FolderDetailsDto : FolderDto
    {
        public List<FolderDto> Folders { get; set; }
        public List<DocumentDto> Documents { get; set; }
    }
}
